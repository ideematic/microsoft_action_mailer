require_relative 'storages/redis' if defined?(Redis)

module MicrosoftActionMailer
  class DeliveryMethod
    attr_accessor :tenant_id, :client_api, :client_id, :token_storage

    def initialize params = {}
      delivery_options = params[:delivery_options] || {}
      @tenant_id = delivery_options[:tenant_id] || ''
      @client_id = delivery_options[:client_id] || ''
      @token_storage = delivery_options[:token_storage]
      @token_storage = Storages::Redis.instance if @token_storage.nil? && defined? Redis
      raise 'storage must be defined, see redis.rb' if @token_storage.nil?
      raise 'tenant_id must be defined' if @tenant_id.blank?
      raise 'client_id must be defined' if @client_id.blank?

      @client_api = MicrosoftApi.new @tenant_id, @client_id
    end

    def deliver! mail, opts = {}
      begin
        @client_api.send_mail! @token_storage.get('@@MicrosoftActionMailer/Token'), mail
      rescue RestClient::Unauthorized => e
        rsp = @client_api.request_new_token(@token_storage.get('@@MicrosoftActionMailer/RefreshToken'))
        @token_storage.set('@@MicrosoftActionMailer/Token', rsp['access_token'])
        @token_storage.set('@@MicrosoftActionMailer/RefreshToken', rsp['refresh_token'])
        deliver! mail, opts # Restart after the refresh was made
      end
    end
  end
end

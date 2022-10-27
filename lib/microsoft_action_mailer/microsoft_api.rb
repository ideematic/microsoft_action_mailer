require 'rest-client'

module MicrosoftActionMailer
  class MicrosoftApi
    @@MAILER_API = 'https://graph.microsoft.com/v1.0/me/sendMail'

    attr_accessor :tenant_id, :client_id

    def initialize(tenant_id, client_id)
      @tenant_id = tenant_id
      @client_id = client_id
    end

    def send_mail!(token, email_addresses, subject, body)
      payload = {
        'message' => {
          'subject' => subject,
          'body' => {
            'contentType' => 'HTML',
            'content' => body
          },
          'toRecipients' => email_addresses.map { |mail| {'emailAddress' => {'address' => mail}} }
        },
        'saveToSentItems' => 'false'
      }
      RestClient.post(@@MAILER_API, payload.to_json, {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      })
    end

    def request_new_token(refresh_token)
      payload = {
        client_id: @client_id,
        scope: 'offline_access Mail.Send',
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }
      rsp = RestClient.post("https://login.microsoftonline.com/#{@tenant_id}/oauth2/v2.0/token", payload)
      JSON.parse rsp.body
    end
  end
end
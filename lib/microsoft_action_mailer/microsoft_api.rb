require 'rest-client'

module MicrosoftActionMailer
  class MicrosoftApi
    @@MAILER_API = 'https://graph.microsoft.com/v1.0/me/sendMail'

    attr_accessor :tenant_id, :client_id

    def initialize(tenant_id, client_id)
      @tenant_id = tenant_id
      @client_id = client_id
    end

    def send_mail!(token, mail)
      payload = {
        'message' => {
          'subject' => mail.subject,
          'body' => {
            'contentType' => 'HTML',
            'content' => mail.html_part.decoded
          },
          'toRecipients' => mail.to.map { |mail| {'emailAddress' => {'address' => mail}} }
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
        scope: 'Mail.Read Mail.Send User.Read profile openid email',
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }
      rsp = RestClient.post("https://login.microsoftonline.com/#{@tenant_id}/oauth2/v2.0/token", payload)
      JSON.parse rsp.body
    end
  end
end
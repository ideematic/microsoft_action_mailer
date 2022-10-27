module MicrosoftActionmailer
  class Railtie < Rails::Railtie
    initializer 'microsoft_action_mailer.add_delivery_method', before: 'action_mailer.set_configs' do
      ActionMailer::Base.add_delivery_method(:microsoft_api, ::MicrosoftActionMailer::DeliveryMethod)
    end
  end
end
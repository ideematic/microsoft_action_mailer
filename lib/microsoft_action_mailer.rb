# frozen_string_literal: true

require_relative "microsoft_action_mailer/version"
require_relative 'microsoft_action_mailer/microsoft_api'
require_relative "microsoft_action_mailer/delivery_method"
require_relative 'microsoft_action_mailer/railtie' if defined?(Rails)

module MicrosoftActionMailer
  class Error < StandardError; end
  # Your code goes here...
end

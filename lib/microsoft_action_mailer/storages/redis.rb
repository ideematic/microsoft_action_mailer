require 'redis'

module MicrosoftActionMailer
  module Storages
    class Redis
      include Singleton

      attr_accessor :redis_client

      def initialize
        @redis_client = ::Redis.new
      end

      def get(key)
        @redis_client.get(key)
      end

      def set(key, value)
        @redis_client.set(key, value)
      end
    end
  end
end
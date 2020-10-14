# frozen_string_literal: true

module SlackRubyBotServer
  module RealTime
    module Config
      extend self

      ATTRIBUTES = %i[
        callbacks
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset!
        self.callbacks = Hash.new { |h, k| h[k] = [] }
      end

      def on(type, *values, &block)
        value_key = values.compact.join('/') if values.any?
        key = [type.to_s, value_key].compact.join('/')
        callbacks[key] << block
      end

      def run_callbacks(type, value, args)
        callbacks = []

        keys = ([type.to_s] + Array(value)).compact

        # more specific callbacks first
        while keys.any?
          callbacks += self.callbacks[keys.join('/')]
          keys.pop
        end

        return nil unless callbacks&.any?

        callbacks.each do |c|
          rc = c.call(args || value)
          return rc if rc
        end

        nil
      end
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end

SlackRubyBotServer::RealTime::Config.reset!

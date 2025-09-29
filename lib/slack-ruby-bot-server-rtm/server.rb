# frozen_string_literal: true

require_relative 'ext/slack-ruby-bot/client'

module SlackRubyBotServer
  module RealTime
    class Server < ::SlackRubyBot::Server
      attr_accessor :team

      def initialize(attrs = {})
        attrs = attrs.dup
        @team = attrs.delete(:team)
        raise 'Missing team' unless @team

        attrs[:token] = @team.token
        super
        open!
      end

      def self.start_server!(team, server, wait = 1)
        team.server = server
        server.start_async
      rescue StandardError => e
        SlackRubyBotServer::Config.service_class.instance.send(:run_callbacks, :error, team, e)
        case e.message
        when 'account_inactive', 'invalid_auth'
          if team.respond_to?(:oauth_version) && team.oauth_version != 'v1'
            SlackRubyBotServer::Config.service_class.instance.logger.info "#{team.name}: #{e.message}, team OAuth scope has been upgraded."
          else
            SlackRubyBotServer::Config.service_class.instance.logger.error "#{team.name}: #{e.message}, team will be deactivated."
            SlackRubyBotServer::Config.service_class.instance.deactivate! team
          end
        else
          wait = e.retry_after if e.is_a?(Slack::Web::Api::Errors::TooManyRequestsError)
          SlackRubyBotServer::Config.service_class.instance.logger.error "#{team.name}: #{e.message}, restarting in #{wait} second(s)."
          sleep(wait)
          start_server! team, server, [wait * 2, 60].min
        end
      end

      def restart!(_wait = 1)
        # when an integration is disabled, a live socket is closed, which causes the default behavior of the client to restart
        # it would keep retrying without checking for account_inactive or such, we want to restart via service which will disable an inactive team
        SlackRubyBotServer::Config.service_class.instance.logger.info "#{team.name}: socket closed, restarting ..."
        SlackRubyBotServer::Config.service_class.instance.restart! team
        open!
      end

      private

      def open!
        client.owner = team
      end
    end
  end
end

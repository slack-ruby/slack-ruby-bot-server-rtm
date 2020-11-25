# frozen_string_literal: true

SlackRubyBotServer.configure do |config|
  config.oauth_scope ||= ['bot']
end

SlackRubyBotServer::Config.service_class.instance.on :starting do |team, _error, options|
  next if team.respond_to?(:oauth_version) && team.oauth_version != 'v1'

  SlackRubyBotServer::Config.service_class.instance.logger.info "Starting real-time team #{team}."
  options = { team: team }
  server = SlackRubyBotServer::RealTime::Config.server_class.new(options)
  SlackRubyBotServer::RealTime::Server.start_server! team, server
end

SlackRubyBotServer::Config.service_class.instance.on :restarting do |team, _error, options|
  SlackRubyBotServer::Config.service_class.instance.logger.info "Restarting real-time team #{team}."
  SlackRubyBotServer::RealTime::Server.start_server! team, server, options[:wait]
end

SlackRubyBotServer::Config.service_class.instance.on :stopped do |team, _error, _options|
  SlackRubyBotServer::Config.service_class.instance.logger.info "Stopping real-time team #{team}."
  begin
    team.server&.stop!
  ensure
    team.server = nil
  end
end

SlackRubyBotServer::Config.service_class.instance.on :deactivated do |team, _error, _options|
  SlackRubyBotServer::Config.service_class.instance.logger.info "De-activating real-time team #{team}."
  team.server = nil
end

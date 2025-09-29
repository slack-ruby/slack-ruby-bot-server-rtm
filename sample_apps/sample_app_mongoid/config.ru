# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

Bundler.require :default

require_relative 'commands'

Mongoid.load!(File.expand_path('config/mongoid.yml', __dir__), ENV.fetch('RACK_ENV', nil))

NewRelic::Agent.manual_start

SlackRubyBotServer::App.instance.prepare!
SlackRubyBotServer::Service.start!

run SlackRubyBotServer::Api::Middleware.instance

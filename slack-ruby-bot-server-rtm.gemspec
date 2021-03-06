# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack-ruby-bot-server-rtm/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack-ruby-bot-server-rtm'
  spec.version       = SlackRubyBotServer::RealTime::VERSION
  spec.authors       = ['Daniel Doubrovkine']
  spec.email         = ['dblock@dblock.org']

  spec.summary       = 'Slack RTM bot extension for slack-ruby-bot-server.'
  spec.homepage      = 'https://github.com/slack-ruby/slack-ruby-bot-server-rtm'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'async-websocket', '~> 0.8.0'
  spec.add_dependency 'slack-ruby-bot', '>= 0.12.0'
  spec.add_dependency 'slack-ruby-bot-server', '>= 1.0.0'
end

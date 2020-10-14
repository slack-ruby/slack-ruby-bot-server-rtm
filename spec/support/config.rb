# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    SlackRubyBotServer::RealTime::Config.reset!
  end
end

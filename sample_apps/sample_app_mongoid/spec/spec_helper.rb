# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

ENV['RACK_ENV'] = 'test'

require 'mongoid'
require 'database_cleaner-mongoid'
require 'slack-ruby-bot-server-rtm/rspec'

Mongoid.load!(File.expand_path('../config/mongoid.yml', __dir__), ENV.fetch('RACK_ENV', nil))

RSpec.configure do |config|
  config.before :suite do
    Mongoid::Tasks::Database.create_indexes
    DatabaseCleaner.start
  end

  config.after :suite do
    DatabaseCleaner.clean
  end
end

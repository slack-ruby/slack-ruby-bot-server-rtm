# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

ENV['RACK_ENV'] = 'test'

require 'active_record'
require 'database_cleaner'
require 'slack-ruby-bot-server-rtm/rspec'

db_config = YAML.safe_load(File.read(File.expand_path('../config/postgresql.yml', __dir__)), [], [], true)[ENV.fetch('RACK_ENV', nil)]
ActiveRecord::Tasks::DatabaseTasks.create(db_config)
ActiveRecord::Base.establish_connection(db_config)

RSpec.configure do |config|
  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

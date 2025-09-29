# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

ENV['RACK_ENV'] = 'test'

require 'active_record'
require 'database_cleaner'
require 'pagy_cursor'
require 'slack-ruby-bot-server-rtm/rspec'

yml = ERB.new(File.read(File.expand_path('../config/postgresql.yml', __dir__))).result
db_config = YAML.safe_load(yml, aliases: true)[ENV.fetch('RACK_ENV', nil)]

ActiveRecord::Tasks::DatabaseTasks.create(db_config)
ActiveRecord::Base.establish_connection(db_config)

RSpec.configure do |config|
  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

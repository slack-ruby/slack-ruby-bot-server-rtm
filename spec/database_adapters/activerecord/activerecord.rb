# frozen_string_literal: true

db_config = YAML.safe_load(File.read(File.expand_path('postgresql.yml', __dir__)), [], [], true)[ENV.fetch('RACK_ENV', nil)]
ActiveRecord::Tasks::DatabaseTasks.create(db_config)
ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger.level = :info

# frozen_string_literal: true

yml = ERB.new(File.read(File.expand_path('postgresql.yml', __dir__))).result
db_config = YAML.safe_load(yml, aliases: true)[ENV.fetch('RACK_ENV', nil)]

ActiveRecord::Tasks::DatabaseTasks.create(db_config)
ActiveRecord::Base.establish_connection(db_config)
ActiveRecord::Base.logger ||= Logger.new(STDOUT)
ActiveRecord::Base.logger.level = :info

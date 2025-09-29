# frozen_string_literal: true

source 'https://rubygems.org'

case ENV.fetch('DATABASE_ADAPTER', nil)
when 'mongoid'
  gem 'kaminari-mongoid'
  gem 'mongoid'
  gem 'mongoid-scroll'
when 'activerecord'
  gem 'activerecord', '~> 5.0.0'
  gem 'otr-activerecord', '~> 1.2.1'
  gem 'virtus'
  gem 'cursor_pagination' # rubocop:disable Bundler/OrderedGems
  gem 'pg'
when nil
  warn "Missing ENV['DATABASE_ADAPTER']."
else
  warn "Invalid ENV['DATABASE_ADAPTER']: #{ENV.fetch('DATABASE_ADAPTER', nil)}."
end

gemspec

group :development, :test do
  gem 'bundler'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'faker'
  gem 'hyperclient'
  gem 'rack-test'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop', '1.81.1'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'vcr'
  gem 'webmock'
end

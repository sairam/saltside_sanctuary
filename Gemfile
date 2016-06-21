source 'https://rubygems.org'

RAILS_VERSION = '4.2.6'
# gem 'rails', RAILS_VERSION
gem 'activesupport', RAILS_VERSION
gem 'actionpack',    RAILS_VERSION
gem 'railties',      RAILS_VERSION
gem 'bundler',       '>= 1.3.0', '< 2.0'

# Database
gem 'mongoid'

# gem 'json-schema'


group :development, :test do
  gem 'pry'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  # gem 'rspec_expectation_count' # works only with ruby >= 2.2.4
  gem 'timecop'
  gem 'factory_girl_rails'
  gem 'mongoid-rspec', '3.0.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

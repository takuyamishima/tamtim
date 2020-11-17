source 'https://rubygems.org'

ruby '2.7.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'dotenv-rails'
gem 'carrierwave'
gem 'mini_magick'
gem 'kaminari'
gem 'gretel'
gem 'font-awesome-rails'
gem 'rails_12factor'
gem 'fog-aws'
gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'impressionist'
gem 'acts-as-taggable-on'
gem 'counter_culture'
gem 'amazon-ecs'
gem 'google-analytics-rails'
gem 'meta-tags'
gem 'slack-notifier'
gem 'slim-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'factory_bot_rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'slim_lint', require: false
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'html2slim'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


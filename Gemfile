source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'sinatra'

# Asset template engines
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

gem 'jquery-rails'

# async wrappers
gem 'eventmachine',     :git => 'git://github.com/eventmachine/eventmachine.git'
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', '1.0.0', :require => ['em-synchrony', 'em-synchrony/em-http', 'em-synchrony/activerecord']

# async activerecord requires
gem 'mysql2'

# async http requires
gem 'em-http-request',:git => 'git://github.com/igrigorik/em-http-request.git', :require => 'em-http'
gem 'addressable', :require => 'addressable/uri'

gem 'thin'

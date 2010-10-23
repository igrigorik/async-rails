source 'http://rubygems.org'

gem 'rails', '3.0.1'
gem 'sinatra'

# async wrappers
gem 'eventmachine',     :git => 'git://github.com/eventmachine/eventmachine.git'
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony',     :git => 'git://github.com/igrigorik/em-synchrony.git', :require => [
  'em-synchrony',
  'em-synchrony/em-http'
  ]

# async activerecord requires
gem 'mysqlplus',      :git => 'git://github.com/oldmoe/mysqlplus.git',        :require => 'mysqlplus'
gem 'em-mysqlplus',   :git => 'git://github.com/igrigorik/em-mysqlplus.git',  :require => 'em-activerecord'

# async http requires
gem 'em-http-request',:git => 'git://github.com/igrigorik/em-http-request.git', :require => 'em-http'
gem 'addressable', :require => 'addressable/uri'

gem 'thin'

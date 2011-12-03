# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# include Rack::FiberPool in your stack and
# set the number of fibers in the pool (100 is the current defaukt)

# mounting AssetPipeline before FiberPool to avoid stack level to deep error
# for development environment
map '/assets' do
  AsyncRails3::Application.configure do
    config.assets.compile = true
  end
  run AsyncRails3::Application.assets
end if Rails.env.development?

map '/' do
  use Rack::FiberPool, :size => 100
  run AsyncRails3::Application
end

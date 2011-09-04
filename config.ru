# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# include Rack::FiberPool in your stack and
# set the number of fibers in the pool (100 is the current defaukt)
use Rack::FiberPool, :size => 100
run AsyncRails3::Application

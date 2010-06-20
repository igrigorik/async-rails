# Async Rails 3 stack demo

Simple async demo stack with Rails 3 + EventMachine and Fibers.

 * Hit localhost:3000/widgets to do a 1s async mysql query
 * Hit localhost:3000/widgets/http to make an HTTP call back to /widgets - recursive! :-)

Requirements:

 * Ruby 1.9.x
 * Async app server (thin)
 * Rails 3

Environment setup:

 * rvm install 1.9.2-preview3
 * rvm use 1.9.2-preview3%rails3
 * gem install rails3 --pre

Starting up Rails:

 * bundle install
 * thin -D start

Test:

ab -c 5 -n 10 http://127.0.0.1:3000/widgets/http

        Concurrency Level:      5
        Time taken for tests:   2.740 seconds
        Complete requests:      10

Scenario:

 * AB opens 5 concurrent requests (10 total)
 * Each request to /widgets/http opens an async HTTP request to /widgets - aka, we ourselves spawn another 5 requests
 * Because the fiber pool is set to 10, it means we can process all 5 requests within ~1s (each mysql req takes 1s)
 * 10 requests finish in ~2s

So, keep in mind that the size of 'database pool' is basically your concurrency throttle. In example above, we spawn
10 requests, which open another 10 internally, so in total we process 20 req's in ~2s on a single thing server. Just as expected.

Resources:

 * http://www.slideshare.net/igrigorik/no-callbacks-no-threads-railsconf-2010
 * http://www.igvita.com/2010/06/07/rails-performance-needs-an-overhaul/
 * http://www.igvita.com/2010/04/15/non-blocking-activerecord-rails/
 * http://www.igvita.com/2010/03/22/untangling-evented-code-with-ruby-fibers/

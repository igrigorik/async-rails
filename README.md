# Async Rails 3.1 stack demo

Important warning:
  
  You should be aware when using fibers with Rails that you can get a stack overflow error if your stack grows  
  bigger than 4Kb (which is enough for most things though), this got even worse with the 3.1 release in which  
  you can easily overflow the stack, here is an example [here](https://github.com/schmurfy/assets_crash).

Simple async demo stack with Rails 3.1 + EventMachine and Fibers.

 * Hit localhost:3000/widgets to do a 1s async mysql query
 * Hit localhost:3000/widgets/http to make an HTTP call back to /widgets - recursive! :-)
 * Hit localhost:3000/twitter to load a mounted async Sinatra app (reports latests rails 3 tweets)

Howto / example commits:

  * Modify your config.ru to include the Rack::FiberPool middleware: [config.ru](https://github.com/igrigorik/async-rails/commit/72ea38433246cc58cd31e3863f4ed4e0c861ad28#config.ru)
  * Configure ActiveRecord to use async mysql driver: [Gemfile](https://github.com/igrigorik/async-rails/blob/master/Gemfile#L16), and [database.yml](https://github.com/igrigorik/async-rails/blob/master/config/database.yml#L4)
  * [Use async HTTP fetching within Rails](http://github.com/igrigorik/async-rails/commit/6307f3f416f21a40304d2f4a07509b923051744b)
  * [Mount async Sinatra app](http://github.com/igrigorik/async-rails/commit/50c5e4fd6701dfa2b3ecfc697ca53b40f8c57827)

Requirements:

 * Ruby 1.9.x
 * Async app server (thin)
 * Rails 3.1

Environment setup:

 * rvm install 1.9.2
 * rvm gemset create async-rails
 * rvm use 1.9.2@async-rails
 * gem install rails thin

Starting up Rails:

 * bundle install
 * bundle exec thin -D start

## Concurrency

ab -c 5 -n 10 http://127.0.0.1:3000/widgets/

        Concurrency Level:      5
        Time taken for tests:   2.740 seconds
        Complete requests:      10

We're running on a single reactor, so above is proof that we can execute HTTP+MySQL queries in non-blocking fashion on a single run loop / within single process:

 * AB opens 5 concurrent requests (10 total)
 * Each request to /widgets/http opens an async HTTP request to /widgets - aka, we ourselves spawn another 5 requests
 * Because the fiber pool is set to 10, it means we can process all 5 requests within ~1s (each mysql req takes 1s)
 * 10 requests finish in ~2s

So, keep in mind that the size of 'database pool' is basically your concurrency throttle. In example above, we spawn
10 requests, which open another 10 internally, so in total we process 20 req's in ~2s on a single thing server. Just as expected.

## Benchmarks

Pushing the stack on my MBP (db pool = 250; fiber pool = 250; env = production; thin 1.2.7) results in:

        Concurrency Level:      220
        Time taken for tests:   10.698 seconds
        Complete requests:      2000
        Failed requests:        0
        Write errors:           0
        Total transferred:      470235 bytes
        HTML transferred:       12006 bytes
        Requests per second:    186.95 [#/sec] (mean)
        Time per request:       1176.777 [ms] (mean)
        Time per request:       5.349 [ms] (mean, across all concurrent requests)
        Transfer rate:          42.93 [Kbytes/sec] received

For full AB trace see [this gist](http://gist.github.com/503627)

Resources:

 * [No callbacks, No threads - RailsConf 2010 Presentation](http://www.slideshare.net/igrigorik/no-callbacks-no-threads-railsconf-2010)
 * [Rails performance needs an overhaul](http://www.igvita.com/2010/06/07/rails-performance-needs-an-overhaul/)
 * [Non-blocking ActiveRecord](http://www.igvita.com/2010/04/15/non-blocking-activerecord-rails/)
 * [Untangling evented code with Ruby fibers](http://www.igvita.com/2010/03/22/untangling-evented-code-with-ruby-fibers/)
 * [Introducing Phat, and Async Rails app](http://www.mikeperham.com/2010/04/03/introducing-phat-an-asynchronous-rails-app/)

Other: 

 * [Postgres + Async Rails driver](https://github.com/leftbee/em-postgresql-adapter)
 * [Fix: Asset Pipeline + Stack level too deep error](https://github.com/igrigorik/async-rails/wiki/Asset-Pipeline-+-Stack-Level-to-Deep)
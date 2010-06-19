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

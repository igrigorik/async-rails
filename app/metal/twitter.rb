class Twitter < Sinatra::Base
  get '/twitter' do
    http = EM::HttpRequest.new("http://search.twitter.com/search?q=rails+3&format=json").get
    tweets = ActiveSupport::JSON.decode(http.response)
    tweets = tweets['results'].collect {|t| t['text'] }.join("</br>")
    tweets
  end
end
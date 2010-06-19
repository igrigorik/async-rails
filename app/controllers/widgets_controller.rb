class WidgetsController < ApplicationController
  def index
    Widget.find_by_sql("select sleep(1)")
    render :text => "Oh hai"
  end

  def http
    # going meta, query yourself, on the same thin server!
    http = EM::HttpRequest.new("http://localhost:3000/widgets").get
    render :text => http.response
  end
end
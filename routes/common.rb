
class JMApp < Sinatra::Base
  ##----
  ## Set the cache-control for Varnish to cache the pages in my
  ## Heroku App
  ## 
  ## Configure default notes to show at top of page.
  ##----
  before do
    cache_control :public, :max_age => 7200
    @notes = ""
  end
end

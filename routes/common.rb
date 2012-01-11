##----
## Set the cache-control for Varnish to cache the pages in my
## Heroku App
## 
## Configure default notes to show at top of page.
##----
before do
  cache_control :public, :max_age => 86400
  @notes = ""
end




##----
## Server LESS CSS files as css
##----
get '/css/stylesheet.css' do
  less :stylesheet
end
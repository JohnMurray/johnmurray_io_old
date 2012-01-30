require './sinatra-app.rb'

configure :production do
  require 'newrelic_rpm'
end

run Sinatra::Application

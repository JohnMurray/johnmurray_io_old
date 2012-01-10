require 'haml'
require 'less'
require 'maruku'
require 'sinatra'
require './config/sinatra-config'
require './lib/prettifier-helper'



##----
## Load all of the Sinatra routes
##----
['common', 'home', 'contact', 'logs', 'random'].each do |r|
  require "./routes/#{r}"
end

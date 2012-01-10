require 'haml'
require 'less'
require 'maruku'
require 'time'
require 'sinatra'
require './config/sinatra-config'
require './lib/prettifier-helper'



##----
## Load all of the Sinatra routes
##----
[
  'common', 
  'home', 
  'contact', 
  'logs', 
  'rss',
  'random'
].each do |r|
  require "./routes/#{r}"
end

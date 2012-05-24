require 'haml'
require 'less'
require 'uri'
require 'time'
require 'sinatra'
require './config/sinatra-config'
require './lib/prettifier-helper'



##----
## Load all of the Sinatra routes
##----
%w(common home contact logs rss random).each do |r|
  require "./routes/#{r}"
end

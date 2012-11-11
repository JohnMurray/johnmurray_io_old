require 'uri'
require 'time'
require 'bundler'
Bundler.require(ENV['RACK_ENV'].to_sym)




class JMApp < Sinatra::Base

  configure do
    enable :static, :logging, :dump_errors
  end

  configure :development do
    enable :raise_errors
    enable :show_exceptions
  end

  configure :production do
    require 'newrelic_rpm'
  end
end



##----
## Load all of the Sinatra routes
##----
require_relative 'routes/init'

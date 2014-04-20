require 'uri'
require 'time'
require 'bundler'
Bundler.require(ENV['RACK_ENV'].to_sym)




class JMApp < Sinatra::Base

  BASE_CACHE_OPTS = { 
    compress:     true,
    expires_in:   86_400,  #(1 day)
    namespace:    'jm.io'
  }

  def initialize
    super
    @cache = Dalli::Client.new(settings.cache_hosts, settings.cache_opts)
  end

  configure do
    enable :static, :logging, :dump_errors
    set :haml, { :ugly => true }
  end

  configure :development do
    enable :raise_errors
    enable :show_exceptions

    set :cache_opts, BASE_CACHE_OPTS
    set :cache_hosts, 'localhost:11211'
  end

  configure :production do
    cache_opts = BASE_CACHE_OPTS.dup
    cache_opts[:username] = ENV['MEMCACHEDCLOUD_USERNAME']
    cache_opts[:password] = ENV['MEMCACHEDCLOUD_PASSWORD']

    set :cache_opts, cache_opts
    set :cache_hosts, ENV['MEMCACHEDCLOUD_SERVERS'].split(',')
  end
end



##----
## Load all of the Sinatra routes
##----
require_relative 'routes/init'

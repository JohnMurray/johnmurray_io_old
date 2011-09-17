require 'haml'
require 'sinatra'
require './config/sinatra-config.rb'

get '/' do 
  haml :index
end

get '/contact' do
  @body = :contact
  haml :template
end

get '/log' do
  @body = :log
  haml :template
end

get '/log/:year/:month/:day/:title' do
end

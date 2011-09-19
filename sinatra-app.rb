require 'haml'
require 'less'
require 'sinatra'
require './config/sinatra-config.rb'

get '/' do 
  haml :index
end

get '/contact' do
  haml :contact
end

get '/log' do
  @files = []
  regex = /blogs\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/
  Dir[File.join("blogs", "**", "*.md")].each do |file|
    match_data = regex.match file
    @files << {
      path:  "/log/#{match_data[:year]}/#{match_data[:month]}/#{match_data[:day]}/#{match_data[:title]}",
      name:  match_data[:title].gsub(/([^-])-([^-])/, '\1 \2').gsub('--', '-').gsub('.md', ''),
      date:  Time.new(match_data[:year], match_data[:month], match_data[:day])
    }
  end
  #haml :log
  @files.inspect.to_s
end

get '/log/:year/:month/:day/:title' do
end


##----
## Server LESS CSS files as css
##----
get '/stylesheet.css' do
  less :stylesheet
end

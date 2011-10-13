require 'haml'
require 'less'
require 'maruku'
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
  haml :log
end

get '/log/:year/:month/:day/:title' do
  markdown_file = File.open(File.join(
    "blogs",
    params[:year],
    params[:month],
    params[:day],
    params[:title])).read
  doc = Maruku.new(markdown_file)
  @doc = doc.to_html
  haml :log_entry
end


##----
## Server LESS CSS files as css
##----
get '/stylesheet.css' do
  less :stylesheet
end


get '/google2457dd570105c571.html' do
  File.open('google2457dd570105c571.html').read
end

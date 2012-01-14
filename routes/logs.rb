require 'uri'


$: << ::File.expand_path('../../lib', __FILE__)
require 'log-helper'

##----
## A directory of all 'log entries' that are currently in progress. This will
## not be visible from the main site. It is solely for the purpose of demo'ing
## my log entries to myself to ensure proper formatting.
##----
get '/logs/pre' do
  @files = []
  regex = /blogs\/in-the-works\/(?<title>.*\.md)/
  Dir[File.join('blogs', 'in-the-works', '_*.md')].each do |file|
    match = regex.match file
    title_url = URI.escape(match[:title], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    @files << {
      path:  "/log/pre/#{title_url}",
      name:  format_title(match[:title]),
      date:  Time.now
    }
  end
  haml :log
end



##----
## Load a specific 'log entry' that is in the works for review. As the normal
## log entries, this is just a markdown file.
##----
get '/log/pre/*' do
  @js_s = PrettifierHelper.get_scripts ['ruby', 'scala', 'css', 'yaml']

  title = params[:splat].join('')

  markdown_file = File.open(File.join(
    'blogs',
    'in-the-works',
    title)).read
  doc = Maruku.new(markdown_file)
  @doc = doc.to_html
  @doc_title = format_title(title)
  haml :log_entry
end


##----
## A directory of all 'log entries'. A log entry is just a blog of
## sorts although, I don't expect anyone to be reading it.
##----
get '/log' do
  @files = []
  regex = /blogs\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/
  Dir[File.join("blogs", "**", "[^_]*.md")].each do |file|
    match = regex.match file
    @files << {
      path:  "/log/#{match[:year]}/#{match[:month]}/#{match[:day]}/#{match[:title]}",
      name:  format_title(match[:title]),
      date:  Time.new(match[:year], match[:month], match[:day])
    }
  end
  haml :log
end



##----
## Load a specific 'log entry' to show. This is just markdown file
## that we are parsing and loading into a page.
##----
get '/log/:year/:month/:day/:title' do
  @js_s = PrettifierHelper.get_scripts ['ruby', 'scala', 'css', 'yaml']

  file_name = File.join(
    'blogs',
    params[:year],
    params[:month],
    params[:day],
    params[:title])

  if File.exist? "#{file_name}.notes"
    @notes = File.open("#{file_name}.notes").read
  end

  markdown_file = File.open(file_name).read
  doc = Maruku.new(markdown_file)
  @doc = doc.to_html
  @doc_title = format_title(params[:title])
  haml :log_entry
end


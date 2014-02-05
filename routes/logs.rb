$: << ::File.expand_path('../../lib', __FILE__)
require 'log-helper'

class JMApp < Sinatra::Base
  ##----
  ## A directory of all 'log entries' that are currently in progress. This will
  ## not be visible from the main site. It is solely for the purpose of demo'ing
  ## my log entries to myself to ensure proper formatting.
  ##----
  get '/log/pre' do
    with_cache('log-pre') do

      regex = /blogs\/in-the-works\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/
      path = File.join('blogs', 'in-the-works', '**', '_*.md')
      pre = true

      @files = with_cache('log-pre-file-list') { log_list(path, regex, pre) }

      haml :log
    end
  end



  ##----
  ## Load a specific 'log entry' that is in the works for review. As the normal
  ## log entries, this is just a markdown file.
  ##----
  get '/log/pre/:year/:month/:day/*' do
    with_cache(request.path_info) do
      title = params[:splat].join('')

      file_name = File.join(
        'blogs',
        'in-the-works',
        params[:year],
        params[:month],
        params[:day],
        title)

      if File.exist? "#{file_name}.notes"
        @notes = File.open("#{file_name}.notes").read
      end

      @doc = parse_file(file_name)
      @doc_title = format_title(title)

      haml :log_entry
    end
  end


  ##----
  ## A directory of all 'log entries'. A log entry is just a blog of
  ## sorts although, I don't expect anyone to be reading it.
  ##----
  get '/log' do
    with_cache('log') do

      regex = /blogs\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/
      path = File.join("blogs", "**", "[^_]*.md")
      @files = with_cache('log-file-list') { log_list(path, regex) }

      haml(:log)
    end
  end



  ##----
  ## Load a specific 'log entry' to show. This is just markdown file
  ## that we are parsing and loading into a page.
  ##----
  get '/log/:year/:month/:day/*' do
    with_cache(request.path_info) do
      title = params[:splat].join('')

      file_name = File.join(
        'blogs',
        params[:year],
        params[:month],
        params[:day],
        title)

      if File.exist? "#{file_name}.notes"
        @notes = File.open("#{file_name}.notes").read
      end

      @doc = parse_file(file_name)
      @doc_title = format_title(title)
      haml :log_entry
    end
  end
end

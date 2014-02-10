$: << ::File.expand_path('../../lib', __FILE__)
require 'log-helper'

class JMApp < Sinatra::Base
  LOG_META = {
    regex: /blogs\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/,
    path:  File.join("blogs", "**", "[^_]*.md")
  }

  LOG_PRE_META = {
    regex: /blogs\/in-the-works\/(?<year>\d+)\/(?<month>\d+)\/(?<day>\d+)\/(?<title>.*\.md)/,
    path:  File.join('blogs', 'in-the-works', '**', '_*.md')
  }

  ##----
  ## A directory of all 'log entries' that are currently in progress. This will
  ## not be visible from the main site. It is solely for the purpose of demo'ing
  ## my log entries to myself to ensure proper formatting.
  ##----
  get '/log/pre' do
    with_cache('log-pre') do

      pre = true

      @files = with_cache('log-pre-file-list') { 
        log_list(LOG_PRE_META[:path], LOG_PRE_META[:regex], pre) 
      }

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

      @files = with_cache('log-file-list') { 
        log_list(LOG_META[:path], LOG_META[:regex]) 
      }

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
      @related_logs = related_logs(@doc_title)

      haml :log_entry
    end
  end



  ##----
  ## Public: Build a list of 'file' objects (same as used when showing
  ## the log-list(s)) and return the items that are related to the current
  ## post (specified by the 'title' parameter).
  ## 
  ## Params:
  ##   title  Title of article to compare with file-list to find current.
  ##   pre    Boolean indicating whether this is a finished or work-in-progress
  ##          (pre) log entry. Determines different file-list to process.
  ## 
  ## Returns an array of hashes with a pre-determined maximum length
  ## 
  ##----
  def related_logs(title, pre=false)

    logs = begin
      if pre
        with_cache('log-pre-file-list') {
          log_list(LOG_PRE_META[:path], LOG_PRE_META[:regex], pre)
        }
      else
        with_cache('log-file-list') {
          log_list(LOG_META[:path], LOG_META[:regex])
        }
      end
    end

    related_files = []
    curr_file = logs.select{|l| l[:name] == title}.first
    logs.delete(curr_file)
    top_logs = logs.select{|l| l[:date] > curr_file[:date]}.reverse

    if curr_file
      top_logs.each do |l|
          related_files << l if related_files.count < 3 && title != l[:name]
      end
    else
      related_files = logs.take(3)
    end

    if related_files.count < 3
      related_files.concat(logs.take(3 - related_files.count)).uniq!
    end

    related_files.sort{|a,b| b[:date] <=> a[:date]}
  end
end

require 'rdiscount'

##----
## format the title from the file name into the displayable title
##----
def format_title(title)
  title.gsub(/([^-])-([^-])/, '\1 \2')
       .gsub(/([^-])-([^-])/, '\1 \2')
       .gsub('--', '-')
       .gsub('.md', '')
end

##----
## Public: Parse a log file (markdown) into html
##
## Params:
##   file_name  File to be read from disk and parsed as Markdown
##
## Returns string containing HTML content (from parsed markdown)
##----
def parse_file(file_name)
  markdown_file = File.open(file_name).read
  doc = RDiscount.new(markdown_file)
  doc.to_html
end


##----
## Public: Get a list of log-entries and collect their path (on the 
## internet), name, and date published. 
##
## Params:
##   path   The file-path to iterate over (should contain a glob)
##   regex  The regular expression to match and extract article information
##          from the file-name and path
##   pre    Boolean indicating whether this is a finished or work-in-progress
##          (pre) log entry. Determines slight variation in link target.
##
## Return an array of hashes, sorted by the date. Example format:
##
##   [
##     { path: "/log/2013/05/13/Scala-by-Example.md",
##       name: "Scala By Example",
##       date: "2013-05-13 00:00:00 -0400" }, ...
##   ]
##----
def log_list(path, regex, pre=false)
  add_sep = pre ? '/pre' : ''
  files = []

  Dir[path].each do |file|
    match = regex.match file
    title_url = URI.escape(match[:title], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    files << {
      path:  "/log#{add_sep}/#{match[:year]}/#{match[:month]}/#{match[:day]}/#{title_url}",
      name:  format_title(match[:title]),
      date:  Time.new(match[:year], match[:month], match[:day])
    }
  end
  files.sort{|a,b| b[:date] <=> a[:date]}
end

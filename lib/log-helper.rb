require 'maruku'

## format the title from the file name into the displayable title
def format_title(title)
  title.gsub(/([^-])-([^-])/, '\1 \2')
       .gsub(/([^-])-([^-])/, '\1 \2')
       .gsub('--', '-')
       .gsub('.md', '')
end

## Parse a log file (markdown) into html
def parse_file(file_name)
  markdown_file = File.open(file_name).read
  doc = Maruku.new(markdown_file)
  doc.to_html
end

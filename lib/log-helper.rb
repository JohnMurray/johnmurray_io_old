

def format_title(title)
  title.gsub(/([^-])-([^-])/, '\1 \2')
       .gsub('--', '-')
       .gsub('.md', '')
end

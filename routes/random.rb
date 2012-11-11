class JMApp < Sinatra::Base
  ##----
  ## Load a specific random data-set.
  ##----
  get '/*/:name' do
    file_name = File.join('random', params[:name])

    if File.exist? "#{file_name}.notes"
      @notes = File.open("#{file_name}.notes").read
    end

    markdown_file = File.open(file_name).read
    doc = RDiscount.new(markdown_file)
    @doc = doc.to_html
    @doc_title = params[:name]
                  .gsub(/([^-])-([^-])/, '\1 \2')
                  .gsub('--', '-')
                  .gsub('.md', '')
    haml :random_entry
  end



  ##----
  ## A directory of everything else that doesn't fit into the site.
  ## This may inlclude old sites, research, random stuff, etc.
  ##----
  get '/*' do
    @notes = "Herein lies some random bytes of data about me (and possibly other 
              items) that don't fit into my site otherwise. Some of it might be 
              of interest, other pieces you may find a tad mundane. Either way, 
              enjoy!"

    @files = []
    regex = /random\/(?<name>.+\.md)/
    Dir[File.join('random', '*.md')].each do |file|
      match = regex.match file
      @files << {
        path: "/*/#{match[:name]}",
        name: match[:name]
                .gsub(/([^-])-([^-])/, '\1 \2')
                .gsub('--', '-')
                .gsub('.md', '')
      } if match
    end

    haml :random
  end
end

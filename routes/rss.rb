##----
## 
## 
##----
get '/rss' do
  regex = /blogs\/(?<y>\d+)\/(?<m>\d+)\/(?<d>\d+)\/(?<t>.*\.md)/
  @logs = Dir[File.join("blogs", "**", "[^_]*.md")]
 
  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.tag! "rss", :version => '2.0', "xmlns:atom".to_sym => "http://www.w3.org/2005/Atom" do
      xml.channel do
        xml.title "JohnMurray.io"
        xml.description "Log entries of my interests and endeavours"
        xml.link "http://johnmurray.io"
        xml.tag! "atom:link", 
          :href => 'http://johnmurray.io/rss',
          :rel  => 'self', 
          :type => 'application/rss+xml'

        @logs.each do |log|
          m = regex.match log
          title = m[:t]
                 .gsub(/([^-])-([^-])/, '\1 \2')
                 .gsub('--', '-')
                 .gsub('.md', '')

          markdown_file = File.open(log).read
          doc = Maruku.new(markdown_file)

          xml.item do
            xml.title title
            xml.link "http://johnmurray.io/log/#{m[:y]}/#{m[:m]}/#{m[:d]}/#{m[:t]}"
            xml.description doc.to_html
            xml.pubDate Time.parse("#{m[:y]}-#{m[:m]}-#{m[:d]}").rfc822
            xml.guid "http://johnmurray.io/log/#{m[:y]}/#{m[:m]}/#{m[:d]}/#{m[:t]}"
          end
        end
      end
    end
  end
end

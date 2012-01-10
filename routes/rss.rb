##----
## 
## 
##----
get '/rss' do
  regex = /blogs\/(?<y>\d+)\/(?<m>\d+)\/(?<d>\d+)\/(?<t>.*\.md)/
  @logs = Dir[File.join("blogs", "**", "[^_]*.md")]

  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => '2.0' do
      xml.channel do
        xml.title "JohnMurray.io"
        xml.description "Log entries of my interests and endeavours"
        xml.link "http://johnmurray.io"

        @logs.each do |log|
          m = regex.match log
          markdown_file = File.open(log).read
          doc = Maruku.new(markdown_file)

          xml.item do
            xml.title m[:t]
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

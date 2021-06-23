require 'open-uri'
require 'nokogiri'

class Crawler
  def initialize
    
  end

  def get_cheetsheet
    doc = Nokogiri::HTML(URI.open("http://www.pragtob.info/rails-beginner-cheatsheet/"))
    # content = doc.css('div#content-wrapper')
    # footer = doc.css('footer')
    file = File.new("crawler.html", "w")
    file.puts doc
  end
end

if $PROGRAM_NAME == __FILE__
  Crawler.new.get_cheetsheet()
end

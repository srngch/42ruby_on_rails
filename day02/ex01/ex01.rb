#!/usr/bin/ruby -w

class Html
  attr_reader :page_name

  def initialize(name)
    @page_name = name
    head()
  end

  def head
    raise_msg = "A file named #{@page_name}.html already exist!" 
    raise RuntimeError, raise_msg if File.file?("#{@page_name}.html")
    file = File.new("#{@page_name}.html", "w")
    file.puts "<!DOCTYPE html>"
    file.puts "<html>"
    file.puts "<head>"
    file.puts "<title>#{@page_name}</title>"
    file.puts "</head>"
    file.puts "<body>"
    file.close if file
  end
  
  def dump(string)
    file = File.open("#{@page_name}.html", "a+")
    raise_msg = "There is no body tag in #{@page_name}.html"
    raise RuntimeError, raise_msg unless file.readlines.include?("<body>\n")
    raise_msg2 = "Body has already been closed in #{@page_name}.html"
    raise RuntimeError, raise_msg2 if file.readlines.include?("</body>\n")
    file.puts "  <p>#{string}</p>"
    file.close if file
  end
  
  def finish
    file = File.open("#{@page_name}.html", "a+")
    raise_msg = "#{@page_name}.html has already been closed."
    raise RuntimeError, raise_msg if file.readlines.include?("</body>\n")
    file.puts "</body>"
    file.close
  end
end

if $PROGRAM_NAME == __FILE__
  a = Html.new("test")
  # a = Html.new("test")
  a.dump("Lorem_ipsum")
  a.dump("Lorem_ipsum")
  # a.finish
  a.finish
end

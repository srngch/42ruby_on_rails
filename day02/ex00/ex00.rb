#!/usr/bin/ruby -w

class Html
  attr_reader :page_name

  def initialize(name)
    @page_name = name
    head
  end
  
  def head
    file = File.new("#{@page_name}.html", "w")
    file.puts "<!DOCTYPE html>"
    file.puts "<html>"
    file.puts "<head>"
    file.puts "<title>#{@page_name}</title>"
    file.puts "</head>"
    file.puts "<body>"
    file.close
  end

  def dump(string)
    file = File.open("#{@page_name}.html", "a")
    file.puts "  <p>#{string}</p>"
    file.close
  end

  def finish
    file = File.open("#{@page_name}.html", "a")
    file.puts "</body>"
    file.close
  end
    
end

if $PROGRAM_NAME == __FILE__
  # require_relative "ex00.rb"
  a = Html.new("test")
  10.times { |x| a.dump("titi_number#{x}") }
  a.finish
end

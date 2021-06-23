#!/usr/bin/ruby -w

class Html
  attr_reader :page_name

  def initialize(name)
    @page_name = name
    head()
  end

  def head
    page_title = @page_name
    begin
      exist_files = Dir.glob(["#{@page_name}.html", "#{@page_name}.*.html"])
      raise Dup_file, "#{@page_name}" if exist_files.length != 0
      file = File.new("#{@page_name}.html", "w")
    rescue Dup_file => e
      file = e.correct
      @page_name = e.explain
    end
    file.puts "<!DOCTYPE html>"
    file.puts "<html>"
    file.puts "<head>"
    file.puts "<title>#{page_title}</title>"
    file.puts "</head>"
    file.puts "<body>"
    file.close if file
  end
  
  def dump(string)
    file = File.open("#{@page_name}.html", "a+")
    begin
      f = file.readlines
      raise RuntimeError, "There is no body tag in #{@page_name}" unless f.include?("<body>\n")
      raise Body_closed, "#{@page_name}" if f.include?("</body>\n")
    rescue Body_closed => e
      e.correct(string)
      e.explain
    else
      file.puts "  <p>#{string}</p>"
    ensure
      file.close if file
    end
  end
  
  def finish
    file = File.open("#{@page_name}.html", "a+")
    raise RuntimeError, "#{@page_name}.html has already been closed." if file.readlines.include?("</body>\n")
    file.puts "</body>"
    file.close if file
  end

end

class Dup_file < StandardError
  def initialize(page_name)
    exist_files = Dir.glob(["#{page_name}.html", "#{page_name}.*.html"])
    e = exist_files.max_by(&:length).split(".")
    @filename = page_name
    @file_num = e.length - 1
    @new_filename = "#{page_name}" + ( ".new" * @file_num)
    show_state
  end

  def show_state
    puts "A file named #{@filename}.html already there: #{Dir.pwd}/#{@filename}.html"
  end

  def correct
    file = File.new("#{@new_filename}.html", "w")
    file
  end
  
  def explain
    puts "Appended .new in order to create requested file: #{@new_filename}.html"
    @new_filename
  end
end

class Body_closed < StandardError
  def initialize(page_name)
    @page_name = page_name
    show_state
  end

  def show_state
    file = File.open("#{@page_name}.html", "r")
    f = file.readlines
    @body_close_tag_linenum = f.index("</body>\n") + 1
    puts "In #{@page_name}.html body was closed :"
    print "  > In :#{@body_close_tag_linenum} </body> :"
    file.close
  end

  def correct(string)
    content = File.read("#{@page_name}.html")
    replace = content.gsub(/<\/body>\n/, "")
    file = File.open("#{@page_name}.html", "w")
    file.puts replace
    file.puts "  <p>#{string}</p>"
    file.puts "</body>"
    file.close
  end 
  
  def explain
    puts "text has been inserted and tag moved at the end of it."
  end 
end

if $PROGRAM_NAME == __FILE__
  a = Html.new("test")
  b = Html.new("test")
  a.dump("Lorem_ipsum")
  a.dump("Lorem_ipsum2")
  a.dump("Lorem_ipsum3")
  b.dump("abc")
  b.dump("abc2")
  b.dump("abc3")
  a.finish
  a.dump("Lorem_ipsum4")
  b.dump("abc4")
  b.finish
end

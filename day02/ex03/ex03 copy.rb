#!/usr/bin/ruby -w

class Elem
  attr_reader :tag, :content, :tag_type, :opt

  def initialize(tag = "", 
                 content = [], 
                 tag_type = "double", 
                 opt = {})
    @tag = tag
    @content = content
    @tag_type = tag_type
    @opt = opt
  end
  
  def add_content(*c)
    if c.first.respond_to?(:concat)
      @content.concat(c.first)
    else
      @content.concat(c)
    end
  end
  
  def to_s
    s = Text.new()
    s.concat("<#{tag}")
    opt.each { |k, v| s.concat(" #{k}='#{v}'") } unless opt.empty?
    case tag_type
    when "simple"
      s.concat(" />")
    else # "double"
      s.concat(">")
      unless @content.empty?
        if content.class == String || content.class == Text 
          s.concat("#{Text.new(content)}")
        else
          @content.each { |c|
            s.concat("\n", c.to_s)
          }
          s.concat("\n")
        end
      end
      s.concat("</#{tag}>")	
    end
    s
  end
end

class Text < String
  def initialize(string = "")
    super(string)
  end
end

if $PROGRAM_NAME == __FILE__  
  body = Elem.new('body')
  head = Elem.new('head')
  h1 = Elem.new('h1',Text.new('"Oh no, not again!"'))
  title = Elem.new('title', Text.new('"Hello ground!"'))
  img = Elem.new('img', '', 'simple',{'src':'http://i.imgur.com/pfp3T.jpg'})
  html = Elem.new('html')
  head.add_content(title)
  body.add_content(h1, img)
  html.add_content(head, body)
  puts "-------html.to_s-----"
  puts body.to_s
  puts "-------compare!------"
  puts "<html>\n<head>\n<title>\"Hello ground!\"</title>\n</head>\n<body>\n<h1>\"Oh no, not again!\"</h1>\n<img src='http://i.imgur.com/pfp3T.jpg' />\n</body>\n</html>"
  puts "----test-----"
  puts "Elem == #{body.content[0].class}"
  puts "Text == #{body.content[0].content.class}"
  puts "Elem == #{body.content[1].class}"

end

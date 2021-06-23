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
    s = String.new()
    s.concat("<#{tag}")
    opt.each { |k, v| s.concat(" #{k}='#{v}'") } unless opt.empty?
    case tag_type
    when "simple"
      s.concat(" />")
    else # "double"
      s.concat(">")
      # unless @content.empty?
        if content.class == String || content.class == Text 
          s.concat("#{Text.new(content)}")
        else
          @content.each { |c|
            s.concat("\n", c.to_s)
          }
          s.concat("\n")
        end
      # end
      s.concat("</#{tag}>")	
    end
    s
  end
end

class Text
  def initialize(str)
    @str = str
  end

  def to_s
    @str.is_a?(String) ? @str : @str.to_s
  end
end

class Html < Elem
  def initialize(content = [], opt = {})
    super("html", content, "double", opt)
  end
end

class Head < Elem
  def initialize(content = [], opt = {})
    super("head", content, "double", opt)
  end
end

class Body < Elem
  def initialize(content = [], opt = {})
    super("body", content, "double", opt)
  end
end

class Title < Elem
  def initialize(content = [], opt = {})
    super("title", content, "double", opt)
  end
end

class Meta < Elem
  def initialize(content = [], opt = {})
    super("meta", content ,"simple", opt)
  end
end

class Img < Elem
  def initialize(content = [], opt = {})
    super("img", content ,"simple", opt)
  end
end

class Table < Elem
  def initialize(content = [], opt = {})
    super("table", content, "double", opt)
  end
end

class Th < Elem
  def initialize(content = [], opt = {})
    super("th", content, "double", opt)
  end
end

class Tr < Elem
  def initialize(content = [], opt = {})
    super("tr", content, "double", opt)
  end
end

class Td < Elem
  def initialize(content = [], opt = {})
    super("td", content, "double", opt)
  end
end

class Ul < Elem
  def initialize(content = [], opt = {})
    super("ul", content, "double", opt)
  end
end

class Ol < Elem
  def initialize(content = [], opt = {})
    super("ol", content, "double", opt)
  end
end

class Li < Elem
  def initialize(content = [], opt = {})
    super("li", content, "double", opt)
  end
end

class H1 < Elem
  def initialize(content = [], opt = {})
    super("h1", content, "double", opt)
  end
end

class H2 < Elem
  def initialize(content = [], opt = {})
    super("h2", content, "double", opt)
  end
end

class P < Elem
  def initialize(content = [], opt = {})
    super("p", content, "double", opt)
  end
end

class Div < Elem
  def initialize(content = [], opt = {})
    super("div", content, "double", opt)
  end
end

class Span < Elem
  def initialize(content = [], opt = {})
    super("span", content, "double", opt)
  end
end

class Hr < Elem
  def initialize(content = [], opt = {})
    super("hr", content ,"simple", opt)
  end
end

class Br < Elem
  def initialize(content = [], opt = {})
    super("br", content ,"simple", opt)
  end
end

if $PROGRAM_NAME == __FILE__
  puts (head = Head.new)
  puts (body = Body.new)
  puts (title = Title.new)
  puts (meta = Meta.new)
  puts (img = Img.new)
  puts (table = Table.new)
  puts (th = Th.new)
  puts (tr = Tr.new)
  puts (td = Td.new)
  puts (ul = Ul.new)
  puts (ol = Ol.new)
  puts (li = Li.new)
  puts (h1 = H1.new)
  puts (h2 = H2.new)
  puts (pp = P.new)
  puts (div = Div.new)
  puts (span = Span.new)
  puts (hr = Hr.new)
  puts (br = Br.new)
  puts (text = Text.new("text!!!!"))
  puts puts puts
  puts Html.new([
    Head.new([Title.new("Hello ground!")]), 
    Body.new([
      H1.new(Text.new("Oh no, not again!")),
      Img.new([], {"src":"http://i.imgur.com/pfp3T.jpg"}) 
    ]) 
  ])
end

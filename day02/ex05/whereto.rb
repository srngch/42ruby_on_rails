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
        if content.class == Array
          @content.each { |c|
            s.concat("\n", c.to_s)
          }
          s.concat("\n")
        else
          s.concat("#{Text.new(content)}")
        end
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

class Page
  def initialize(elem)
    @elem = elem
  end

  def is_valid?
    status_ok = check_elem_in_tree(@elem)
    result = status_ok ? "FILE IS OK" : "FILE IS KO!"
    puts "             " + result
  end
  
  private

  def check_elem_in_tree(elem)
    return false unless check_elem(elem)
    
    if elem.content.class != Array
      return false unless check_elem(elem.content)
    else
      puts "Evaluating a multiple node" if elem.content.size > 0 && check_children_type(elem, [Title, Meta, Img, Table, Th, Tr, Td, Ul, Ol, Li, H1, H2, P, Div, Span, Hr, Br, Text])
      elem.content.each { |c|
        return false unless check_elem_in_tree(c)
      }
    end
    true
  end

  def check_elem(elem)
    # puts "Currently evaluating a #{elem.class} :"
    return false unless check_elem_type(elem)
    case elem
    when Html
      puts "Currently evaluating a #{elem.class} :"
      puts "- root element of type \"html\""
      puts "- Html -> Must contains a Head AND a Body after it"
      head = elem.content[0].class
      check_head = head == Head
      puts "Error: First children is not a Head" unless check_head
      body = elem.content[1].class
      check_body = body == Body
      puts "Error: Second children is not a Body" unless check_body
      check_count = elem.content.count == 2
      puts "Error: Children is not a Head and a Body" unless check_count
      return false unless check_head && check_body && check_count
    when Head
      check = count_children(elem, Title) == 1
      puts "Error: Head must contains only one Title" unless check
      return false unless check
      puts "#{elem.class} is OK"
    when Body, Div
      check = check_children_type(elem, [H1, H2, Div, Table, Ul, Ol, Span, Text])
      return false unless check
    when Title, Th, Td, Li, H1, H2
      check_only = has_only_child(elem, Text)
      check_type = check_children_type(elem, [Text])
      puts "Error: #{elem.class} must contains only one Text" unless check_only
      return false unless check_only && check_type
    when Table
      check_tr = count_children(elem, Tr) > 0
      puts "Error: Table must contains some Tr" unless check_tr
      return false unless check_tr && check_children_type(elem, [Tr])
    when Ul, Ol
      check_li = count_children(elem, Li) > 0
      puts "Error: #{elem.class} must contains some Li" unless check_li
      return false unless check_li && check_children_type(elem, [Li])
    when Img
      puts "Currently evaluating a #{elem.class} :"
      check_src = elem.opt[:src].class == Text
      puts "Error: Img must contains src field" unless check_src
      return false unless check_src
      puts "#{elem.class} content is OK"
    when Tr
      th_or_td = count_children(elem, Th) > 0 || count_children(elem, Td) > 0
      puts "Error: Tr must contains some Th or Td" unless th_or_td
      return false unless th_or_td && check_children_type(elem, [Th, Td])
    when P
      check_text = count_children(elem, Text) > 0
      puts "Error: P must contains some Text" unless check_text
      return false unless check_text && check_children_type(elem, [Text])
    when Span
      text_or_p = count_children(elem, Text) > 0 || count_children(elem, P) > 0
      puts "Error: Tr must contains some Th or Td" unless text_or_p
      return false unless text_or_p && check_children_type(elem, [Text, P])
    when Text
      puts "Currently evaluating a #{elem.class} :"
      check_string = elem.to_s.class == String
      puts "Error: Text must contains a simple string" unless check_string
      return false unless check_string
      puts "-Text -> Must contains a simple string"
      puts "#{elem.class} content is OK"
    else
      # puts "#{elem.class} is OK"
    end
    true
  end

  def count_children(elem, class_type)
    childs = Array.new
      elem.content.each { |c|
      childs.push(c.class)
    }
    return childs.count(class_type)
  end

  def has_only_child(elem, class_type)
    return true if elem.content.class != Array
    count = elem.content.size
    return count == 1 && elem.content[0].class == class_type
  end

  def check_elem_type(elem)
    ok_elems = [Html, Head, Body, Title, Meta, Img, Table, Th, Tr, Td, Ul, Ol, Li, H1, H2, P, Div, Span, Hr, Br, Text]

    ok_elems.each { |o|
      return true if elem.class == o
    }
    return false
  end

  def check_children_type(elem, class_types)
    if elem.content.class != Array
      class_types.each { |o|
        return true if elem.content.class == o
      }
    else
      elem.content.each { |e|
        class_types.each { |o|
          return true if e.class == o
        }
      }
    end
    puts "Error: Children type is not valid in a #{elem.class}"
    return false
  end

  def find_tag_node(elem, tag)
    r = elem if elem.class == tag
    elem.content.each { |c|
      next if c.content.class == Text
      r = find_tag_node(c, tag)
    }
    return r
  end
end
  
if $PROGRAM_NAME == __FILE__
  toto = Html.new([
    Head.new([
      Title.new(Text.new("Hello ground!")),
      # Title.new(Meta.new([], {'charset': 'UTF-8'})), # KO WITH THIS
      Meta.new([], {'charset': 'UTF-8'})
    ]),
    Body.new([
      H1.new(Text.new("Oh no, not again!")), 
      Img.new([], {'src': Text.new('http://i.imgur.com/pfp3T.jpg')}),
      # Img.new([], {}) # ver.KO IMG
      Table.new([
        Tr.new([
          Th.new(Text.new("th!!!")),
          # Th.new(),
          Td.new(Text.new("td!!!"))
        ])
      ])
    ])
  ])
  puts "----------------------------------------"
  puts toto
  puts "----------------------------------------"
        test = Page.new(toto)
  test.is_valid?
  # puts puts puts
  # tata = Html.new([
  #   Head.new([
  #     Title.new(Text.new("Hello ground!"))
  #   ]), 
  #   Body.new([
  #     H1.new(Text.new("Oh no, not again!")), 
  #     Img.new([], {'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) 
  #   ]),
  #   Body.new([
  #     H1.new(Text.new("Oh no, not again!")), 
  #     Img.new([], {'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) 
  #   ]) 
  # ]) 
  # puts "----------------------------------------"
  # puts tata
  # puts "----------------------------------------"
  # test2 = Page.new(tata)
  # test2.is_valid? 
end

# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative "ft_wikipedia/version"

class Ft_wikipedia
  def initialize
  end

  def self.search(word)
    new_word = word
    visited = {}
    pages = 0
    puts "First search @ :https://en.wikipedia.org/wiki/#{new_word}"

    begin
      loop do
        pages += 1
        return pages if new_word == "Philosophy"

        doc = Nokogiri::HTML(URI.open("https://en.wikipedia.org/wiki/#{new_word}"))
        links = doc.css('div#bodyContent p a[href*="/wiki/"]')
        
        links[0..10].each { |n|
          new_word = n.to_s.split("/")[2].split("\"")[0]
          break unless n.content[0] == '[' || \
          n.content[0] == '{' || \
          n.content[0] == '('
        }
        
        visited[new_word] = 0 unless visited[new_word]
        visited[new_word] += 1 if visited[new_word]
        raise StandardError, "Loop detected there is no way to philosophy here" if visited[new_word] > 2
        raise StandardError, "Dead end page reached" if new_word.empty?
        puts "https://en.wikipedia.org/wiki/#{new_word}"
      end
    rescue => e
      puts "#{e.message}"
    end
  end

end

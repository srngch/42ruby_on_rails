# frozen_string_literal: true

require "test_helper"

class Ft_wikipediaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ft_wikipedia::VERSION
  end
  
  def test_find_page
    assert_equal 1, Ft_wikipedia.search("Philosophy")
  end

  def test_error_loop
    assert "Loop detected there is no way to philosophy here", Ft_wikipedia.search("matter")
  end
  
  # def test_error_stalemate
  #   assert "Dead end page reached", Ft_wikipedia.search("?")
  # end
end



# require_relative 'ft_wikipedia.rb'
# Ft_wikipedia.search("Philosophy")
# Ft_wikipedia.search("matter")
# Ft_wikipedia.search("Effects_of_blue_lights_technology")

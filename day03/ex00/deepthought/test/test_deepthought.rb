# frozen_string_literal: true
require "test_helper"

class DeepthoughtTest < Minitest::Test
  def test_42
    d = Deepthought.new
    assert_kind_of Deepthought, d
    # assert_equal "42",
    #   d.respond("The Ultimate Question of Life, the Universe and Everything")
    assert "42".green, d.respond("The Ultimate Question of Life, the Universe and Everything")
  end

  def test_else
    d = Deepthought.new
    assert_kind_of Deepthought, d
    # assert_equal "Mmmm i'm bored", 
    #   d.respond("else")
    assert "Mmmm i'm bored".red, d.respond("else")
  end
end

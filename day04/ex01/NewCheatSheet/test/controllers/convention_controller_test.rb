require "test_helper"

# class ConventionControllerTest
class ConventionControllerTest < ActionDispatch::IntegrationTest
  test "should get console" do
    get convention_console_url
    assert_response :success
  end

  test "should get ruby" do
    get convention_ruby_url
    assert_response :success
  end

  test "should get ruby-concepts" do
    get convention_ruby-concepts_url
    assert_response :success
  end

  test "should get ruby-numbers" do
    get convention_ruby-numbers_url
    assert_response :success
  end

  test "should get ruby-strings" do
    get convention_ruby-strings_url
    assert_response :success
  end

  test "should get ruby-arrays" do
    get convention_ruby-arrays_url
    assert_response :success
  end

  test "should get ruby-hashes" do
    get convention_ruby-hashes_url
    assert_response :success
  end

  test "should get rails-folder-structure" do
    get convention_rails-folder-structure_url
    assert_response :success
  end

  test "should get rails-commands" do
    get convention_rails-commands_url
    assert_response :success
  end

  test "should get rails-erb" do
    get convention_rails-erb_url
    assert_response :success
  end

  test "should get editor" do
    get convention_editor_url
    assert_response :success
  end

  test "should get help" do
    get convention_help_url
    assert_response :success
  end
end

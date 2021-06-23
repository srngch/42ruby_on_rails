require "test_helper"

# class MainControllerTest < ActionDispatch::IntegrationTest
class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get convention" do
    get main_convention_url
    assert_response :success
  end

  test "should get console" do
    get main_console_url
    assert_response :success
  end

  test "should get ruby" do
    get main_ruby_url
    assert_response :success
  end

  test "should get ruby-concepts" do
    get main_ruby-concepts_url
    assert_response :success
  end

  test "should get ruby-numbers" do
    get main_ruby-numbers_url
    assert_response :success
  end

  test "should get ruby-strings" do
    get main_ruby-strings_url
    assert_response :success
  end

  test "should get ruby-arrays" do
    get main_ruby-arrays_url
    assert_response :success
  end

  test "should get ruby-hashes" do
    get main_ruby-hashes_url
    assert_response :success
  end

  test "should get rails-folder-structure" do
    get main_rails-folder-structure_url
    assert_response :success
  end

  test "should get rails-commands" do
    get main_rails-commands_url
    assert_response :success
  end

  test "should get rails-erb" do
    get main_rails-erb_url
    assert_response :success
  end

  test "should get editor" do
    get main_editor_url
    assert_response :success
  end

  test "should get help" do
    get main_help_url
    assert_response :success
  end
end

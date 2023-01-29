require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @turbo_native_app = false
  end

  test "formats page specific title" do
    content_for(:title) { "Page Title" }

    assert_equal "Page Title | Piazza", title
  end

  test "returns app name when page title is missing" do
    assert_equal "Piazza", title
  end

  test "only page specific title is returned when in turbo native app" do
    @turbo_native_app = true
    content_for(:title) { "Page Title" }

    assert_equal "Page Title", title
  end

  private

  def turbo_native_app?
    @turbo_native_app
  end
end
require "test_helper"

class Admins::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admins_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admins_favorites_destroy_url
    assert_response :success
  end
end

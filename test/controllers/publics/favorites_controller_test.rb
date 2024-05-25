require "test_helper"

class Publics::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get publics_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get publics_favorites_destroy_url
    assert_response :success
  end
end

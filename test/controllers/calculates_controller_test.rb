require "test_helper"

class CalculatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get calculates_new_url
    assert_response :success
  end

  test "should get create" do
    get calculates_create_url
    assert_response :success
  end
end

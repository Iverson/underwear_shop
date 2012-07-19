require 'test_helper'

class CountryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

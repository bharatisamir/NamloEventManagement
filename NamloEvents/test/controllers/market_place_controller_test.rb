require 'test_helper'

class MarketPlaceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get market_place_index_url
    assert_response :success
  end

end

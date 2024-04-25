require "test_helper"

class PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get chatfolio" do
    get portfolio_chatfolio_url
    assert_response :success
  end

  test "should get ispend" do
    get portfolio_ispend_url
    assert_response :success
  end
end

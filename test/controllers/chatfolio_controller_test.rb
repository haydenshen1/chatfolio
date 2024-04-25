require "test_helper"

class ChatfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chatfolio_index_url
    assert_response :success
  end
end

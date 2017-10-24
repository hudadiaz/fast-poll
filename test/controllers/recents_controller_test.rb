require 'test_helper'

class RecentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recents_index_url
    assert_response :success
  end

end

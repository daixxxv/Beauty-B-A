require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    sign_in_as(@user)
  end

  test "should get index" do
    get albums_path
    assert_response :success
  end
end

require "test_helper"

class AlbumFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, password: "password")
  end

  test "should log in and create a new album" do
    sign_in_as(@user)
    assert_redirected_to albums_path
    follow_redirect!

    get new_album_path
    assert_response :success

    assert_difference("Album.count", 1) do
      post albums_path, params: {
        album: {
          title: "沖縄旅行 2026",
          started_on: Date.today
        }
      }
    end

    created_album = Album.last

    assert_redirected_to albums_path
    follow_redirect!

  end

  test "should redirect to login when accessing new album unauthenticated" do
    get new_album_path

    assert_redirected_to new_user_session_path
    assert_no_difference("Album.count") do
      post albums_path, params: {
        album: {
          title: "無効なアルバム",
          started_on: Date.today
        } 
      }
    end
  end

  test "should not create album with invalid params" do
    sign_in_as(@user)
    get new_album_path

    assert_no_difference("Album.count") do
      post albums_path, params: {
        album: {
          title: "",
          started_on: nil
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "body", /を入力してください/
  end

  test "should create an album with attached images" do
    sign_in_as(@user)

    image_file = fixture_file_upload("sample.png", "image/png")

    assert_difference("Album.count", 1) do
      post albums_path, params: {
        album: {
          title: "ビフォーアフター写真付きアルバム",
          started_on: Date.today,
          before_image: image_file,
          after_image: image_file
        }
      }
    end

    created_album = Album.last
    assert created_album.before_image.attached?
    assert created_album.after_image.attached?
  end
end

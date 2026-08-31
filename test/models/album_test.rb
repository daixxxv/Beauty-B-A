require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  test "should be valid with associated user" do
    album = build(:album)
    assert album.valid?
    assert_kind_of User, album.user
  end

  test "can override attributes" do
    custom_user = create(:user, name: "Bob")
    album = create(:album, user: custom_user, title: "Custom Title")

    assert_equal "Bob", album.user.name
    assert_equal "Custom Title", album.title
  end
end

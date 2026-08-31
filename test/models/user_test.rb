require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should require unique email" do
    create(:user, email: "duplicate@example.com")
    new_user = build(:user, email: "DUPLICATE@example.com")

    refute new_user.valid?
    assert new_user.errors[:email].present?
  end
end

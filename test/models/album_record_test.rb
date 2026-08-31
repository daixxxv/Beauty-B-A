require "test_helper"

class AlbumRecordTest < ActiveSupport::TestCase
  def setup
    @album_record = build(:album_record)
  end

  test "should be valid with valid attributes" do
    assert @album_record.valid?
  end

  test "should require an album" do
    @album_record.album = nil
    refute @album_record.valid?
    assert @album_record.errors[:album].present?
  end

  test "should attach before_image and after_image" do
    album_record = build(:album_record, :with_images)
    album_record.save!

    assert album_record.before_image.attached?
    assert album_record.after_image.attached?
  end
end

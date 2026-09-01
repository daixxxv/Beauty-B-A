require 'rails_helper'

RSpec.describe AlbumRecord, type: :model do
  let(:album_record) { build(:album_record) }

  describe 'バリデーション検証' do
    context 'すべての属性が正しく設定されている場合' do
      it '有効であること' do
        expect(album_record).to be_valid
      end
    end
  end

  describe 'アソシエーション（関連付け）のテスト' do
    context 'Album モデルとの関係' do
      it 'Album に属していること (belongs_to :album)' do
        record = create(:album_record)
        expect(record.album).to be_present
      end
    end
  end

  describe 'ActiveStorage 画像添付' do
    it 'before_image と after_image を正常に添付できること' do
      record = create(:album_record, :with_images)
      expect(record.before_image).to be_attached
      expect(record.after_image).to be_attached
    end
  end
end

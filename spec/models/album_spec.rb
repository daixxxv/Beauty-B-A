require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:album) { build(:album) }

  describe 'バリデーション検証' do
    context 'すべての属性が正しく設定されている場合' do
      it '有効であること' do
        expect(album).to be_valid
      end
    end

    context 'タイトル（title）が空の場合' do
      it '無効であること' do
        album.title = nil
        album.valid?
        expect(album.errors[:title]).to include("を入力してください")
      end
    end

    context '開始日（started_on）が空の場合' do
      it '無効であること' do
        album.started_on = nil
        album.valid?
        expect(album.errors[:started_on]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'ユーザーとの関係' do
      it 'User に属していること (belongs_to :user)' do
        record = create(:album)
        expect(record.user).to be_present
      end
    end

    context 'レコードとの関係 (has_many)' do
      it 'Album を削除すると関連する album_records も削除されること (dependent: :destroy)' do
        album = create(:album)
        create(:album_record, album: album)

        expect { album.destroy }.to change(AlbumRecord, :count).by(-1)
      end
    end
  end
end

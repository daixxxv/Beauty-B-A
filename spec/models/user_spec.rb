require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション検証' do
    context 'すべての属性が正しく設定されている場合' do
      it '有効であること' do
        expect(user).to be_valid
      end
    end

    describe '名前（name）のバリデーション' do
      context '名前が空の場合' do
        it '無効であること' do
          user.name = nil
          user.valid?
          expect(user.errors[:name]).to include("を入力してください")
        end
      end

      context '名前が30文字の場合' do
        it '有効であること' do
          user.name = 'a' * 30
          expect(user).to be_valid
        end
      end

      context '名前が31文字以上の場合' do
        it '無効であること' do
          user.name = 'a' * 31
          user.valid?
          expect(user.errors[:name]).to be_present
        end
      end
    end

    describe 'メールアドレス・パスワードのバリデーション (Devise)' do
      context 'メールアドレスが空の場合' do
        it '無効であること' do
          user.email = nil
          user.valid?
          expect(user.errors[:email]).to include("を入力してください")
        end
      end

      context '重複したメールアドレスの場合' do
        it '無効であること' do
          create(:user, email: 'test@example.com')
          duplicate_user = build(:user, email: 'test@example.com')
          duplicate_user.valid?
          expect(duplicate_user.errors[:email]).to be_present
        end
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'アルバムとの関係 (has_many :albums)' do
      it 'ユーザーを削除すると関連するアルバムも削除されること (dependent: :destroy)' do
        user = create(:user)
        create(:album, user: user)

        expect { user.destroy }.to change(Album, :count).by(-1)
      end
    end
  end
end

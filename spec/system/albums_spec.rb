require 'rails_helper'

RSpec.describe 'アルバム機能', type: :system do
  let(:user) { create(:user) }
  let!(:album) { create(:album, user: user, title: '編集前のアルバム', started_on: Date.today) }

  before do
    sign_in user
  end

  describe 'アルバムの新規作成' do
    context '正しい情報を入力した場合' do
      it 'アルバムが正常に作成され、一覧に表示されること' do
        visit new_album_path

        fill_in 'album_title', with: '旅の思い出アルバム'

        fill_in '開始日', with: Date.today

        click_button '作成する'

        expect(page).to have_content '旅の思い出アルバム'
      end
    end
  end

  describe 'アルバムの編集' do
    context '正しい情報を入力して更新した場合' do
      it 'アルバム情報が正常に更新されること' do
        visit edit_album_path(album)

        fill_in 'album_title', with: '更新後のアルバムタイトル'
        click_button '変更を保存する'

        expect(page).to have_content 'アルバムを更新しました'
        expect(page).to have_content '更新後のアルバムタイトル'
        expect(page).not_to have_content '編集前のアルバム'
      end
    end
  end

  describe 'アルバムの削除' do
    it 'アルバムが正常に削除され、一覧から消えること' do
      visit album_path(album)

      page.accept_confirm do
        click_button '削除'
      end

      expect(page).to have_content 'アルバムを削除しました'
      expect(page).not_to have_content '編集前のアルバム'
    end
  end
end
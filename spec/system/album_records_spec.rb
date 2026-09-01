require 'rails_helper'

RSpec.describe 'AlbumRecord (B/A機能)' do
  let(:user) { create(:user) }
  let!(:album) { create(:album, user: user, title: '施術記録アルバム') }

  let!(:album_record) do
    create(:album_record, album: album, title: '初回施術')
  end

  let(:image_path) { Rails.root.join('spec/fixtures/files/sample.jpg') }

  before do
    sign_in user
  end

  describe 'AlbumRecord の新規作成' do
    it 'アルバムに新しい記録（B/A）を追加できること' do
      visit new_album_album_record_path(album)

      fill_in 'album_record_title', with: '2回目の施術結果' if page.has_field?('album_record_title')

      attach_file 'album_record_before_image', image_path if page.has_field?('album_record_before_image')
      attach_file 'album_record_after_image', image_path if page.has_field?('album_record_after_image')

      click_button 'B/A を保存する'

      expect(page).to have_content '2回目の施術結果'
    end
  end

  describe 'AlbumRecord の編集' do
    it '既存の記録が正常に更新されること' do
      visit edit_album_album_record_path(album, album_record)

      fill_in 'album_record_title', with: '2回目施術（変更後）'
      click_button '変更する'

      expect(page).to have_content '2回目施術（変更後）'
      expect(page).not_to have_content '初回施術'
    end
  end

  describe 'AlbumRecord の削除' do
    it '記録が正常に削除されること' do
      visit album_path(album)

      page.accept_confirm do
        if page.has_link?('削除')
          click_link '削除', match: :first
        elsif page.has_button?('削除')
          click_button '削除', match: :first
        end
      end

      expect(page).not_to have_content '初回施術'
    end
  end
end
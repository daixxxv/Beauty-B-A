require 'rails_helper'

RSpec.describe "AlbumRecords", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:album) { create(:album, user: user) }
  let(:album_record) { create(:album_record, album: album) }

  let(:image_file) do
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec/fixtures/files/test_image.png'),
      'image/png'
    )
  end

  describe "GET /albums/:album_id/album_records/new (新規作成画面)" do
    context "ログインしている場合" do
      before { sign_in user }

      it "正常にレスポンスを返すこと" do
        get new_album_album_record_path(album)
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされること" do
        get new_album_album_record_path(album)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /albums/:album_id/album_records (新規登録)" do
    context "ログインしている場合" do
      before { sign_in user }

      context "有効なパラメータの場合" do
        let(:valid_params) do
          {
            album_record: {
              before_date: Date.today,
              after_date: Date.today,
              before_image: image_file,
              after_image: image_file
            }
          }
        end

        it "AlbumRecord が作成されること" do
          expect {
            post album_album_records_path(album), params: valid_params
          }.to change(AlbumRecord, :count).by(1)
        end

        it "アルバム編集画面にリダイレクトされること" do
          post album_album_records_path(album), params: valid_params
          expect(response).to redirect_to edit_album_path(album)
        end
      end
    end

    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされ、作成されないこと" do
        expect {
          post album_album_records_path(album), params: { album_record: { before_date: Date.today } }
        }.not_to change(AlbumRecord, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /albums/:album_id/album_records/:id/edit (編集画面)" do
    context "自分のアルバムのレコードの場合" do
      before { sign_in user }

      it "正常にレスポンスを返すこと" do
        get edit_album_album_record_path(album, album_record)
        expect(response).to have_http_status(:success)
      end
    end

    context "他のユーザーのアルバムのレコードの場合" do
      before { sign_in other_user }

      it "404 Not Found レスポンスが返ること" do
        get edit_album_album_record_path(album, album_record)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /albums/:album_id/album_records/:id (更新)" do
    context "ログインしている場合" do
      before { sign_in user }

      let(:update_params) do
        {
          album_record: {
            before_date: Date.yesterday
          }
        }
      end

      it "レコードが正常に更新されること" do
        patch album_album_record_path(album, album_record), params: update_params
        expect(album_record.reload.before_date).to eq Date.yesterday
      end

      it "アルバム編集画面にリダイレクトされること" do
        patch album_album_record_path(album, album_record), params: update_params
        expect(response).to redirect_to edit_album_path(album)
      end
    end
  end

  describe "DELETE /albums/:album_id/album_records/:id (削除)" do
    context "ログインしている場合" do
      before { sign_in user }
      let!(:target_record) { create(:album_record, album: album) }

      it "AlbumRecord が削除されること" do
        expect {
          delete album_album_record_path(album, target_record)
        }.to change(AlbumRecord, :count).by(-1)
      end

      it "アルバム編集画面にリダイレクトされること" do
        delete album_album_record_path(album, target_record)
        expect(response).to redirect_to edit_album_path(album)
      end
    end
  end
end

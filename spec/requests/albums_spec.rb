require 'rails_helper'

RSpec.describe "Albums", type: :request do
  let(:user) { create(:user) }
  let!(:album) { create(:album, user: user) }

  describe "GET /albums (一覧表示)" do
    context "ログイン済みの場合" do
      before do
        sign_in user
        get albums_path
      end

      it "リクエストが成功すること" do
        expect(response).to have_http_status(:success)
      end

      it "作成したアルバムのタイトルが表示されていること" do
        expect(response.body).to include(album.title)
      end
    end
  end

  describe "POST /albums (新規作成)" do
    context "ログイン済みの場合" do
      before { sign_in user }

      context "パラメータが正しく入力されている場合" do
        let(:valid_params) do
          { album: { title: "新規作成アルバム", started_on: Date.today } }
        end

        it "アルバムが作成されること" do
          expect {
            post albums_path, params: valid_params
          }.to change(Album, :count).by(1)
        end

        it "作成後に一覧ページへリダイレクトされること" do
          post albums_path, params: valid_params
          expect(response).to redirect_to(albums_path)
        end
      end

      context "パラメータが不正な場合" do
        it "登録されず render :new が実行されること" do
          expect {
            post albums_path, params: { album: { title: "" } }
          }.not_to change(Album, :count)

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
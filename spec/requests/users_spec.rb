require 'rails_helper'

RSpec.describe "Users (Devise Integration)", type: :request do
  describe "POST /users (新規ユーザー登録)" do
    let(:valid_user_params) do
      {
        user: {
          name: "テストユーザー",
          email: "new_user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    it "name 属性を含めて正常にユーザー登録ができること" do
      expect {
        post user_registration_path, params: valid_user_params
      }.to change(User, :count).by(1)

      created_user = User.last
      expect(created_user.name).to eq "テストユーザー"
    end

    it "登録成功後、albums_path (アルバム一覧) にリダイレクトされること" do
      post user_registration_path, params: valid_user_params
      expect(response).to redirect_to(albums_path)
    end
  end

  describe "POST /users/sign_in (ログイン)" do
    let!(:user) { create(:user, email: "login_test@example.com", password: "password") }

    it "ログイン成功後、albums_path (after_sign_in_path_for) にリダイレクトされること" do
      post user_session_path, params: { user: { email: user.email, password: "password" } }
      expect(response).to redirect_to(albums_path)
    end
  end
end
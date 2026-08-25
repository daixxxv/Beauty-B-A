class Users::PasswordsController < Devise::PasswordsController
  # POST /resource/password (パスワード更新処理)
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)

      # 自動ログインを行わずにフラッシュメッセージを設定
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message!(:notice, flash_message)

      # ログイン画面へリダイレクト
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # パスワード再設定後のリダイレクト先をログイン画面に指定
  def after_resetting_password_path_for(resource)
    new_user_session_path
  end
end

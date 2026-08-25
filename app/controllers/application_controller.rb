class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name ])
  end

  private

  def after_sign_in_path_for(resource)
    albums_path  # => ログイン後に /albums（アルバム一覧）に飛ぶ
  end
end

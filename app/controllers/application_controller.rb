class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  # deviseのための追加カラム パラメーター許可のため１行記述 nonaka
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseのためのパラメーター許可のため記述 configure_permitted_parametersアクション nonaka privateに移動させています（実装OK）
  protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :date_of_birth, :ship_family_name, :ship_first_name, :ship_family_name_kana, :ship_first_name_kana, :zip_code, :prefecture, :city, :street, :room_number, :tel ])
  # end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # deviseのためのパラメーター許可のため記述 configure_permitted_parametersアクション nonaka
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :date_of_birth, :ship_family_name, :ship_first_name, :ship_family_name_kana, :ship_first_name_kana, :zip_code, :prefecture, :city, :street, :room_number, :tel ])
  end
end

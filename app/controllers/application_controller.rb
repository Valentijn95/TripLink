class ApplicationController < ActionController::Base
  helper_method :no_footer_path
  before_action :configure_permitted_parameters, if: :devise_controller?

  def no_footer_path
    [:root]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end
end

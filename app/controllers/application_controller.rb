class ApplicationController < ActionController::Base
  helper_method :no_footer_path
  before_action :configure_permitted_parameters_update, if: :devise_controller?
  before_action :configure_permitted_parameters_sign_up, if: :devise_controller?

  def no_footer_path
    # array of paths that should not display the footer
  end

  private

  def configure_permitted_parameters_update
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :name, :guide, :short_description, :guide_description, :rate])
  end

  def configure_permitted_parameters_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :name, :guide, :short_description])
  end
end

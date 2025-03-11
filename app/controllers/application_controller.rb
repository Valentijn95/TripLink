class ApplicationController < ActionController::Base
  helper_method :no_footer_path

  def no_footer_path
    [:root]
  end

end

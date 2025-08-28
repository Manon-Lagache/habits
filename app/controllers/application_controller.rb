class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_up_path_for(_resource)
    root_path
  end

  def after_sign_in_path_for(_resource)
    root_path
  end
end

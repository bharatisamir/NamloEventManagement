class ApplicationController < ActionController::Base



  helper_method :current_user
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  #load_and_authorize_resource

  #protect_from_forgery unless: -> { request.format.json? }


  rescue_from CanCan::AccessDenied do |ex|
    flash[:warning] = ex.message
    redirect_to dashboard_index_path
  end



  rescue_from ActiveRecord::RecordNotFound do |e|
    flash[:warning] = 'Sorry, no record was found for your request. Please, make sure your request is valid.'

    if current_user
      redirect_to dashboard_index_path
    else
      redirect_to home_index_path
    end

  end



  def routing_error
    flash[:danger] = 'Routing error. Please, make sure your route is valid.'
    if current_user
      redirect_to dashboard_index_path
    else
      redirect_to home_index_path
    end
  end



  def action_missing(m, *args, &block)
    Rails.logger.error(m)
    redirect_to '/*path'
  end



  def after_sign_in_path_for(resource_or_scope)
     dashboard_index_path
  end


  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end



end

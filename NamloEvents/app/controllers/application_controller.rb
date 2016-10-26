class ApplicationController < ActionController::Base



  helper_method :current_user
  protect_from_forgery with: :exception

  #load_and_authorize_resource

  #protect_from_forgery unless: -> { request.format.json? }


  rescue_from CanCan::AccessDenied do |ex|
    flash[:warning] = ex.message
    redirect_to dashboard_index_path
  end

=begin
  def timer
    $start_time= Time.now
    $signed_at = current_user.current_sign_in_at
    $time_diff = (( $signed_at - $start_time )/60).round
    #$time_diff = $time_diff.strftime("%H:%M")
  end
=end

  def after_sign_in_path_for(resource_or_scope)
     dashboard_index_path
  end


  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end





end

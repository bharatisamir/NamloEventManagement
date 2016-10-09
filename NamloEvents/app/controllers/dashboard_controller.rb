class DashboardController < ApplicationController
  def index
    @user = current_user
    @host = Host.find_by_user_id(@user.id)
    @service_provider = ServiceProvider.find_by_user_id(@user.id)
    @profile = Profile.find_by_user_id(@user.id)
  end
end

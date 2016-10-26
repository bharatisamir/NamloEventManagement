class DashboardController < ApplicationController
  #before_action :timer

  def index
    @user = current_user
    @host = Host.find_by_user_id(@user.id)
    @service_provider = ServiceProvider.find_by_user_id(@user.id)
    @profile = Profile.find_by_user_id(@user.id)

    if @host != nil
      @event = Event.find_by_host_id(@host.id)
    end

  end



end

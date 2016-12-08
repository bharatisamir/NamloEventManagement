class DashboardController < ApplicationController
  #before_action :timer

  def index
    @user = current_user

    $logged_user = current_user

    @host = Host.find_by_user_id(@user.id)
    @service_provider = ServiceProvider.find_by_user_id(@user.id)
    @profile = Profile.find_by_user_id(@user.id)




    @survey = Survey.find(1)

    if @service_provider != nil
      @portfolio = Portfolio.find_by_service_provider_id(@service_provider.id)
      @service_id = Service.find_by_service_name('Event Management').id
      @service_provider_management_service = ServiceProviderService.where((' service_provider_id LIKE ? and service_id LIKE ?'), @service_provider.id, @service_id).first
    end

=begin
    if @service_provider_management_service.present?
      @manger_events = Event.where((' event_manager_id LIKE ? '), @service_provider.id)


    end
=end


    if @host != nil
      @event = Event.find_by_host_id(@host.id)
    end

  end



end

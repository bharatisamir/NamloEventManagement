class MarketPlaceController < ApplicationController


  def index
    @events_on_market = Event.where(publish_on_marketplace:true ).order("created_at desc").paginate(page: params[:page], per_page:6)
    @offers = Offer.all.order("created_at desc").paginate(page: params[:page], per_page:6)
    @service_providers = ServiceProvider.all.order("created_at desc").paginate(page: params[:page], per_page:6)
    @quotations = Quotation.all.order("created_at desc").paginate(page: params[:page], per_page:6)

    if params[:search].present?
      @service_providers = ServiceProvider.select('*').joins(:user).where('first_name LIKE ? OR last_name LIKE ?',"%#{params[:search]}%","%#{params[:search]}%").order("created_at desc").paginate(page: params[:page], per_page:6)
    end

  end
end

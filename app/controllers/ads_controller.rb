class AdsController < ApplicationController
  before_action :check_user_is_logged
  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      flash.now[:success] = "Ad successfully created"
      redirect_to action: "index"
    else
      flash.now[:alert] = @ad.errors.full_messages.join('<br>').html_safe
      render 'ads/new'
    end
  end

  def index
    # Ads listing
    @ads = Ad.order(created_at: :desc)
    @ad_type = "all"
  end

  def edit
    @ad = Ad.find(params[:ad_id])
    render 'new'
  end

  def recruitment_ads
    @ads = Ad.where(ad_type: "Recruitment").order(created_at: :desc)
    @ad_type = "recruitment"
    render 'ads/index'
  end

  def funding_ads
    @ads = Ad.where(ad_type: "Funding").order(created_at: :desc)
    @ad_type = "funding"
    render 'ads/index'
  end

  def mine
    @header_text = "MY ADS"
    @ads = current_user.ads
    @ad_type = false
    render 'ads/index'
  end

  private
  def ad_params
    params.require(:ad).permit(:user_id, :title, :ad_type,
                               :ad_content, :ad_link, :illustration)
  end

  def check_user_is_logged
    redirect_to root_path unless user_signed_in?
  end
end

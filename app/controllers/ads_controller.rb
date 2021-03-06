class AdsController < ApplicationController
  before_action :check_user_is_logged
  before_action :check_owner, only: [:edit, :update, :delete]
  skip_before_action :verify_authenticity_token, only: [:click]
  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      flash.now[:success] = "Ad successfully created"
      redirect_to ad_path
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
    id = params[:id]
    @action_url = ad_update_path(id: id)
    @ad = Ad.find(id)
    render 'new'
  end

  def update
    id = params[:id]
    @ad = Ad.find(id)
    if @ad.update(ad_params)
      redirect_to my_ads_path
    else
      flash.now[:alert] = @ad.errors.full_messages.join('<br>').html_safe
      @action_url = ad_update_path(id: id)
      @ad = Ad.find(id)
      render "new"
    end
  end

  def delete
    @ad = Ad.find(params[:id])
    @ad.delete
    redirect_to ad_path
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

  def click
    @ad = Ad.find(params[:id])
    if @ad.click.nil?
      @ad.click = 1
    else
      @ad.click += 1
    end
    @ad.save
    render json: {
        id: @ad.id,
        clicked: @ad.click
    }
  end

  private
  # TODO: set_ad before_action
  def ad_params
    params.require(:ad).permit(:user_id, :title, :ad_type,
                               :ad_content, :ad_link, :illustration)
  end

  def check_user_is_logged
    redirect_to root_path unless user_signed_in?
  end

  def check_owner
    redirect_to ad_path unless current_user == Ad.find(params[:id]).user
  end
end

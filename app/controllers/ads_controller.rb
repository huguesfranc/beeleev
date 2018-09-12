class AdsController < ApplicationController
  def new
    # Need to be logged
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      # TODO: redirect to ad list
      # render "ads/show"
      # flash.now[:success] = "Ad successfully created"
      puts "ad created"
    else
      flash.now[:alert] = @ad.errors.full_messages.join('<br>').html_safe
      render 'ads/new'
    end
  end

  private
  def ad_params
    params.require(:ad).permit(:user_id, :title, :ad_type, :ad_content, :ad_link)
  end
end

class PacksController < ApplicationController
  before_action :set_professional_status, only: :index
  before_action :set_pack, only: [:edit, :update]

  def index
    @packs = (Pack.kinds.keys - ['free_access']).map { |kind| Pack.new kind: kind }
  end

  def edit

  end

  def update
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @pack.price_in_cents,
      description: @pack.name,
      currency: 'eur'
    )

    @pack.save

    if session[:registration_in_progress] == true
      session.delete :registration_in_progress
      redirect_to onboarding_first_path
    else
      redirect_to account_path
    end
  rescue Stripe::CardError => e
    redirect_to edit_pack_path(pack: params[:pack]), alert: e.message
  end

  protected

  def set_professional_status
    @professional_status = current_user.professional_status
  end

  def set_pack
    @pack = current_user.pack

    if current_user.professional_status == 'local_expert'
      @pack.kind = :expert
    else
      @pack.kind = params[:pack].in?(Pack.kinds.keys - ['free_access']) ? params[:pack] : (@pack.kind == 'free_access' ? 'premium' : @pack.kind)
    end
  end
end

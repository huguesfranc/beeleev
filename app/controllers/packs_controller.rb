class PacksController < ApplicationController
  before_action :set_pack

  def new

  end

  def create
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

    current_user.pack.destroy if current_user.pack

    @pack.user = current_user
    @pack.save

    redirect_to onboarding_first_path
  rescue Stripe::CardError => e
    redirect_to new_pack_path(pack: params[:pack]), alert: e.message
  end

  protected

  def set_pack
    @pack = Pack.new

    if current_user.professional_status == 'local_expert'
      @pack.kind = :expert
    else
      @pack.kind = params[:pack].in?(Pack.kinds.keys - ['free_access']) ? params[:pack] : 'premium'
    end
  end
end

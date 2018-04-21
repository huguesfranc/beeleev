class Users::RegistrationsController < Devise::RegistrationsController

  # Callbacks
  ###########

  before_action :set_professional_status, only: [:new, :create]

  after_action(
    EmailTemplateSender.new("after-new-application", :@user1),
    only: [:create]
  )

  # Actions
  #########

  def new
    # for experience: more sign up inputs split in JS horizontal slider
    @expertises = YAML.load (Rails.root + 'config/expertises.yml').read
    @business_sectors = YAML.load (Rails.root + 'config/business_sectors.yml').read
    build_resource({})
    # render layout: false
    render layout: "website"
  end

  def create

    @user = User.new user_params

    if @user.save
      # For Email template liquid variables
      @user1 = @user

      pack = Pack.new user: @user, kind: params[:pack]

      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: pack.price_in_cents,
        description: pack.name,
        currency: 'eur'
      )

      pack.save

      @user.update pack: pack

      sign_in @user
      # redirect_to edit_account_path
      redirect_to onboarding_first_path
    else
      redirect_to root_path, alert: "Could not save user"
    end
  rescue Stripe::CardError => e
    @user.destroy if @user.persisted?
    redirect_to root_path, alert: e.message
  end

  protected

  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name, :email, :position, :company, :password, :password_confirmation, :country)
      .merge(professional_status: @professional_status)
  end

  def set_professional_status
    @professional_status = params[:professional_status].in?(User.professional_statuses.keys) ? params[:professional_status] : User.professional_statuses.keys.first
  end
end


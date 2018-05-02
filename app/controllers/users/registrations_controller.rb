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

      Pack.create user: @user, kind: :free_access

      sign_in @user

      if @user.professional_status != 'local_expert' && params[:pack] == 'free_access'
        redirect_to onboarding_first_path
      else
        redirect_to edit_packs_path(pack: params[:pack])
      end
    else
      redirect_to root_path, alert: 'Could not save user'
    end
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


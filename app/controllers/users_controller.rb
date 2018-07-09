class UsersController < BeeleeverSpaceController
  before_action :redirect_to_onboarding_first_path, unless: :current_user_fully_registered?


  def show
    user = User.find params[:id]
    @user = user.decorate
  end

  def show_old
    @user = User.find params[:id]
  end

  def redirect_to_onboarding_first_path
    redirect_to onboarding_first_path
  end

  def current_user_fully_registered?
    current_user.fully_registered?
  end
end

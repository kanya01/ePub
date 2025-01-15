class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    authorize @user, :show?
  end

  def edit
    authorize @user, :update?
  end

  def update
    authorize @user, :update?

    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email,
                                 :bio, :avatar, :location, :website)
  end
end

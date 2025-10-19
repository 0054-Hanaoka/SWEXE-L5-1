class ProfilesController < ApplicationController
  before_action :set_user

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = @user.id
    if @profile.save
      redirect_to user_profile_path(@user), notice: "プロフィールを作成しました"
    else
      render :new, status: 422
    end
  end

  def show
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
    @profile ||= @user.build_profile
    @tweets = @user.tweets
  end

  def update
    @profile ||= @user.build_profile
    if @user.update(profile_params)
      redirect_to user_profile_path(@user), notice: "プロフィールとツイートを更新しました"
    else
      @tweets = @user.tweets
      render :edit, status: 422
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_profile
    @profile = @user.profile
  end

  def profile_params
    params.require(:user).permit(
      profile_attributes: [:id, :message],
      tweets_attributes: [:id, :message]
    )
  end
end
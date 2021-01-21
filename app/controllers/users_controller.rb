# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show followings followers]
  before_action :set_current_user, only: :show

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show; end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    User.current = current_user
  end

end

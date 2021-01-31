class Users::ReportsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @reports = @user.reports
  end
end

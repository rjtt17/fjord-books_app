# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.order(:id).page(params[:page])
  end

  # GET /reports/1
  # GET /reports/1.json
  def show; end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    if @report.user_id == current_user.id
      render 'edit'
    else
      redirect_to reports_path
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      ender :new
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    if @report.user_id == current_user.id
      @report.destroy
      redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      redirect_to reports_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :description)
  end
end

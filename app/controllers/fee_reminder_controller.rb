class FeeReminderController < ApplicationController
  def index
    # @sms_statuses = Student.distinct.pluck(:sms_status)
    @sms_statuses = ["error", "sent"]    
    if params[:start_date].present? && params[:end_date].present?
      start_date = params[:start_date].to_date.beginning_of_day
      end_date = params[:end_date].to_date.end_of_day
      @students = Student.where(sent_at: start_date .. end_date).order(sent_at: :desc)
    else
      @students = Student.where(sent_at: Time.zone.today.beginning_of_day .. Time.zone.now).order(sent_at: :desc)
    end
  end
end

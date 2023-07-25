class FeeReminderController < ApplicationController
  def index
    @sms_statuses = Student.distinct.pluck(:sms_status)
    @students = Student.where(fee_pending: true, sms_status: [:sent, :error]).order(sent_at: :desc).page(params[:page])
  end
end

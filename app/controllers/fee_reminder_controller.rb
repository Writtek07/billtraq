class FeeReminderController < ApplicationController
  before_action :check_admin, only: [ :index, :send_message]

  def index
    # @sms_statuses = Student.distinct.pluck(:sms_status)
    @sms_statuses = ["error", "sent"]    
    if params[:start_date].present? && params[:end_date].present? && request.post?
      start_date = params[:start_date].to_date.beginning_of_day
      end_date = params[:end_date].to_date.end_of_day
      @students = Student.where(sent_at: start_date .. end_date).order(sent_at: :desc)
    else
      @students = Student.where(sent_at: Time.zone.today.beginning_of_day .. Time.zone.now).order(sent_at: :desc)
    end
  end

  def send_message
    if params[:message].present?
      Student.kept.first(3).each do |student|          
        begin
          BroadcastMessagesJob.perform_at(2.minutes.from_now, student, params[:message]) 
          StudentMailerJob.perform_at(3.minutes.from_now, student, params[:message])           
        rescue => e
          puts e.message          
        end
      end
      redirect_to fee_reminder_index_path, notice: 'Started sending messages to all students.'
    end
  end

  private

  def check_admin
    if !current_user.admin?
      redirect_to root_path
      flash[:error] = "Unauthorized access!"
    end
  end

end

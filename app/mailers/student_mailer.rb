class StudentMailer < ApplicationMailer
    def send_message(student, message)
      @student = student
      @message = message
      mail(to: @student.email, subject: 'Notice for Parents')
    end
  end
  
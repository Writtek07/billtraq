class SendInvoiceCreatedNotificationJob
  include Sidekiq::Job

  sidekiq_options retry: 6

  #Keeping argument as *_args as I am passing the id after time duration. 
  #Time is key as the delay in sending this enables the total to be present in invoice  
  def perform(*_args)
    invoice = Invoice.find(_args.last)
    student = invoice.student
    if invoice.total.present? && !(invoice.payment_mode == 'Cheque')
      if invoice.month_from == invoice.month_to
        message = "Hello, Parents! Thank you for the payment of Rs.#{invoice.total} for your ward's school fees for the month of #{Services::MonthName.name(invoice.month_from)}. We value your trust in us and assure you that your child's growth and development are our top priorities. Best regards, Mimis Kids School"
      else
        # message = "Dear Parents, Thank you for the payment of Rs.#{invoice.total} towards the fees, for month of #{student.student_name}'s #{Services::MonthName.name(invoice.month_from)}. Regards, Mimis Kids School"
        message = "Hello, Parents! Thank you for the payment of Rs.#{invoice.total} for your ward's school fees from #{Services::MonthName.name(invoice.month_from)} to #{Services::MonthName.name(invoice.month_to)}. We value your trust in us and assure you that your child's growth and development are our top priorities. Best regards, Mimis Kids School"
      end
      Services::SendMessageService.send_message(student,message)
    elsif invoice.total.present? && invoice.payment_mode == 'Cheque'      
      if invoice.month_from == invoice.month_to
        message = "Hello, Parents! Thank you for the payment of Rs.#{invoice.total} for your ward's school fees for the month of #{Services::MonthName.name(invoice.month_from)} via Cheque subjected to clearance. We value your trust in us and assure you that your child's growth and development are our top priorities. Best regards, Mimis Kids School"
      else
        # message = "Dear Parents, Thank you for the payment of Rs.#{invoice.total} towards the fees, for month of #{student.student_name}'s #{Services::MonthName.name(invoice.month_from)}. Regards, Mimis Kids School"
        message = "Hello, Parents! Thank you for the payment of Rs.#{invoice.total} for your ward's school fees from #{Services::MonthName.name(invoice.month_from)} to #{Services::MonthName.name(invoice.month_to)} via Cheque subjected to clearance. We value your trust in us and assure you that your child's growth and development are our top priorities. Best regards, Mimis Kids School"
      end
      Services::SendMessageService.send_message(student,message)
    else
      #Retry these invoices after sometime which can be done by using raise as this becomes an error condition as per sidekiq
      #And then sidekiq automatically retries after sometime
      raise "Invoice doesn't have the 'total' value set yet. Retrying the job..."
    end
  end
end

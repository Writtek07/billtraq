class BroadcastMessagesJob
    include Sidekiq::Job
  
    sidekiq_options retry: 6
  
    #Keeping argument as *_args as I am passing the id after time duration. 
    #Time is key as the delay in sending this enables the total to be present in invoice  
    def perform(*_args)
      student = _args.last(2).first
      message = _args.last
      Services::SendMessageService.send_message(student, message)
    end
  end
  
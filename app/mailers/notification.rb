class Notification < ActionMailer::Base
  default from: "no-reply@topcat.com"
  
  def send_message_notifiction(sender, receiver, message)
    @sender = sender
    @receiver =receiver
    @message = message
    mail(to: @receiver.email, subject: "New Message from #{@receiver.email}")
  end
  
end

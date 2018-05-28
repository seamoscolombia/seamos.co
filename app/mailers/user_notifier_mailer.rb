class UserNotifierMailer < ApplicationMailer
  default :from => 'seamoscolombia@gmail.com'

# send a signup email to the user, pass in the user object that contains the user's email address
  def send_subscription_email(email, unsubscribe)
    @email = email
    @unsubscribe = unsubscribe
    mail( :to => email,
    :subject => 'Ahora estas suscrito al newsletter de SeamOS' )
  end

  def send_general_message(sender, subject, top_image_url, content, recipient)
    @subject = subject
    @content = content
    @recipient = recipient
    @top_image_url = top_image_url
    @sender = sender.present? ? sender : 'seamoscolombia@gmail.com'
    mail( from: @sender, to: recipient, subject: subject, content: content )
  end
end

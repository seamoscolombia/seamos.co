class UserNotifierMailer < ApplicationMailer
  default :from => 'contacto@seamos.co'

# send a signup email to the user, pass in the user object that contains the user's email address
  def send_subscription_email(email, unsubscribe)
    @email = email
    @unsubscribe = unsubscribe
    mail( :to => email, :subject => 'Ahora estas suscrito al newsletter de SeamOS' )
  end

  def send_general_message(sender, subject, top_image_url, content, recipient)
    @subject = subject
    @content = content
    @recipient = recipient
    @top_image_url = top_image_url
    @sender = sender.present? ? sender : 'contacto@seamos.co'
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: recipient, subject: subject, content: content )
  end

  def send_new_poll_mail(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "Incide en las decisiones del Concejo de Bogotá con solo un click: #{poll.title}"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def poll_settled_mail(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "¡Tu voto ha incidido! El/La Concejal #{@poll.author_names} ha radicado proyecto por el que votaste."
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end
end

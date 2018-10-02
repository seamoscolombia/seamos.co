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
    @poll_type = Poll.poll_types[poll.poll_type]
    subject = "¡Tu voto ha incidido! El/La Concejal #{@poll.author_names} ha radicado proyecto por el que votaste."
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def poll_voting_reminder(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "Todavía puedes incidir: #{@poll.title}"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def first_debate_scheduled(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    @poll_type = Poll.poll_types[poll.poll_type]
    subject = "¡Seguimos avanzando! El proyecto en el que votaste ha avanzado un paso más"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def second_debate_scheduled(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "¡Estamos a punto de lograrlo! El proyecto en el que votaste está a un paso de ser una realidad"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def one_day_away_from_first_debate(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    @poll_type = Poll.poll_types[poll.poll_type]
    subject = (@poll_type == 1 ? "Mañana se debate en el Concejo la propuesta en la que participaste" : "Mañana se llevará a cabo el debate de control político en el Concejo de la propuesta en la que participaste")
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def one_day_away_from_second_debate(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "Mañana se debate en el Concejo la propuesta en la que participaste"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def poll_closed_notification(poll, recipient, related_polls, vote_count)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    @vote_count = vote_count
    @poll_type = Poll.poll_types[poll.poll_type]
    subject = "Tu voto cuenta y los bogotanos respondieron la pregunta:  #{@poll.title}"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def agreement_sanction(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "¡Lo logramos! La propuesta en la que votaste se convirtió en un Acuerdo Distrital"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end

  def motion_of_censure(poll, recipient, related_polls)
    @sender = 'contacto@seamos.co'
    @random_polls = related_polls
    @user = recipient
    @poll = poll
    subject = "El control político funcionó, hay moción de censura"
    mail( from: "SeamOS Democracia Digital <#{@sender}>", to: @user.email, subject: subject)
  end
end

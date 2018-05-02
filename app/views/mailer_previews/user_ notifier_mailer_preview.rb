
class UserNotifierMailerPreview < ActionMailer::Preview
  def send_general_message
    @message = {subject: params[:subject], content: params[:content], user_name: 'Celia cruz'}
    UserNotifierMailer.with(user: User.first).send_general_message(@message)
  end
end
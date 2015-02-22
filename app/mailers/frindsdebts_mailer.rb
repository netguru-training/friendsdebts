class FrindsdebtsMailer < ActionMailer::Base
  default from: "notification@friendsdebts.com"

  def new_debt_email(user, group)
    @group = group
    @user = user
    mail(to: @user.email, subject: 'There is new debt to pay')
  end

  def balance_email(user, group, current_user_email)
    @group = group
    @user = user
    @current_user_email = current_user_email
    mail(to: @user.email, subject: 'Debt has been paid')
  end
end

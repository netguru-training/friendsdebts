class FrindsdebtsMailer < ActionMailer::Base
  default from: "notification@friendsdebts.com"

  def new_debt_email(user, group)
    @group = group
    @user = user
    mail(to: @user.email, subject: 'There is new debt to pay')
  end
end

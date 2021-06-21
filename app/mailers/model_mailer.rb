class ModelMailer < ApplicationMailer
  def new_rent_notification(rent, user_email)
    @rent = rent
    @date_time = Time.zone.now
    mail to: user_email, subject: 'Successful rent application', &:text
  end
end

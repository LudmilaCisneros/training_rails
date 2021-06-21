class ContactUserWorker
  include Sidekiq::Worker

  def perform(id)
    rent = Rent.find(id)
    user_email = rent.user.email
    ModelMailer.new_rent_notification(rent, user_email).deliver
  end
end

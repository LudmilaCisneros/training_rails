class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :from, :user, :book,
            :to, presence: true
  after_save { ContactUserWorker.perform_async(id) }
end

class Book < ApplicationRecord
  has_many :rents, dependent: :destroy
  validates :genre, :author, :image,
            :title, :publisher, :year, presence: true
end

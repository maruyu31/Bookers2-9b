class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, length: {maximum: 400}, presence: true
end

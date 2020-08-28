class Question < ApplicationRecord
  belongs_to :user

  # validates :user
  validates :text, presence: true, length: { maximum: 255 }
end

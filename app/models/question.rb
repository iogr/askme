class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: true
  
  validates :text, presence: true, length: { maximum: 255 }

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :with_answers, -> { where.not(answer: nil) }
end

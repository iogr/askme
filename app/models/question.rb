class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :tag_questions, dependent: :destroy
  has_many :tags, through: :tag_questions

  validates :text, presence: true, length: { maximum: 255 }

  after_commit :update_tags, on: [:create, :update]

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :with_answers, -> { where.not(answer: nil) }

  private

  def update_tags
    tag_questions.clear
    "#{text} #{answer}".downcase.scan(Tag::TAG_REGEX).uniq.each do |tag|
      tags << Tag.find_or_create_by(name: tag)
    end
  end
end


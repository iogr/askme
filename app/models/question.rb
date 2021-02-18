class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :tag_questions, dependent: :destroy
  has_many :tags, through: :tag_questions

  validates :text, presence: true, length: { maximum: 255 }

  after_save_commit :update_tags

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :with_answers, -> { where.not(answer: nil) }

  private

  def update_tags
    self.tags =
      "#{text} #{answer}".downcase.scan(Tag::TAG_REGEX).uniq.map do |tag|
        Tag.find_or_create_by(name: tag.delete('#'))
      end
  end
end

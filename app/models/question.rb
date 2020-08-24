class Question < ActiveRecord::Base
  # Эта команда добавляет связь с моделью User на уровне объектов, она же
  # добавляет метод .user к данному объекту.
  #
  # Когда мы вызываем метод user у экземпляра класса Question, рельсы
  # поймут это как просьбу найти в базе объект класса User со значением id,
  # который равен question.user_id.
  belongs_to :user

  validates :text, presence: true, length: { maximum: 255 }
  # Все коллбэки

  # Вызываем специальный метод и в виде символа передаём имя метода (его пишем сами),
  # который будет вызван перед каким-либо действием

  before_validation :before_validation
  after_validation :after_validation

  before_save :before_save
  after_save :after_save

  before_create :before_create
  after_create :after_create

  before_update :before_update
  after_update :after_update

  before_destroy :before_destroy
  after_destroy :after_destroy

  private

  # Этот код нужен только для демонстрации валидаций, потом мы его удалим.
  # Код создаёт все возможные пары методов before_validation, after_validation, before_save и так далее.

  %w(validation save create update destroy).each do |action|
    %w(before after).each do |time|
      define_method("#{time}_#{action}") do
        puts "******> #{time} #{action}"
      end
    end
  end
end


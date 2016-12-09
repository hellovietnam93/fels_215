class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :words, through: :results
  has_many :answers, through: :results
  has_many :results, dependent: :destroy

  validates :category, presence: true

  before_create :init_result
  after_create :create_activity

  scope :order_desc, -> {order created_at: :desc}

  enum status: {init: 0, finished: 1, in_progress: 2}

  accepts_nested_attributes_for :results

  def category_word_count
    errors.add :category,
      I18n.t(".not_enough") unless category.words.count >= Settings.words_minimum
  end

  def init_result
    self.words =
      category.words.order("RANDOM()").limit(category.word_per_lesson)
  end

  def start_lesson
    assign_attributes finish_time: Time.now + category.duration.minutes
    in_progress!
  end

  def set_score
    score = 0
    results.each do |result|
      if result.answer.present? && result.answer.is_correct?
        score += 1
      end
    end
    assign_attributes score: score
  end

  private
  def create_activity
    Activity.create action_type: Activity.action_types[:finished_lesson],
      user_id: self.user_id, target_id: self.id
  end
end

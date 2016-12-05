class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :words, through: :results
  has_many :answers, through: :results
  has_many :results, dependent: :destroy

  validates :category, presence: true

  scope :order_desc, -> {order created_at: :desc}

  enum status: {init: 0, finished: 1, in_progress: 2}

  private
  def category_word_count
    errors.add :category,
      I18n.t(".not_enough") unless category.words.count >= Settings.words_minimum
  end
end

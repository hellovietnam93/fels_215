class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates :duration, presence: true,
    numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :num_ques_per_lesson, presence: true,
    numericality: {greater_than_or_equal_to: 0, only_integer: true}

  scope :sort, -> {order created_at: :desc}
end

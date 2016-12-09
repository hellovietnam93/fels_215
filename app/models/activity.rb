class Activity < ApplicationRecord
  belongs_to :user

  enum action_type: {follow: 0, unfollow: 1, finished_lesson: 2}

  validates :target_id, presence: true
  validates :user_id, presence: true

  scope :order_by_created, ->{order created_at: :desc}
end

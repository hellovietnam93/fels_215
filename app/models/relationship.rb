class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  after_save {create_activity Activity.action_types[:follow]}
  after_destroy {create_activity Activity.action_types[:unfollow]}

  validates :follower, presence: true
  validates :followed, presence: true

  private
  def create_activity type
    Activity.create action_type: type, user_id: self.follower_id, target_id:
      self.followed_id
  end
end

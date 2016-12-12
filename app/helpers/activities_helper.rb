module ActivitiesHelper
  def user_name activity
    if activity.user == current_user
      t "helpers.activities_helper.activity_user_name_you"
    else
      activity.user.name
    end
  end

  def action_message activity
    if activity.follow?
      t "helpers.activities_helper.activity_follow_message"
    elsif activity.unfollow?
      t "helpers.activities_helper.activity_unfollow_message"
    else
      t "helpers.activities_helper.activity_finished_lesson_message"
    end
  end

  def target_link activity
    if activity.finished_lesson?
      @lesson = Lesson.find_by id: activity.target_id
      if @lesson.nil?
        t "helpers.activities_helper.lesson_not_exist"
      else
        link_to @lesson.category.name, @lesson.category
      end
    else
      user = User.find_by id: activity.target_id
      if user.nil?
        t "helpers.activities_helper.user_note_exist"
      else
        link_to user.name, user
      end
    end
  end

  def score_message activity
    if activity.finished_lesson?
      t("helpers.activities_helper.activity_score_message")+
        +score_field(@lesson)
    end
  end
end

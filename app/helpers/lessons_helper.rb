module LessonsHelper

  def action_button lesson
    case lesson.status
    when "init"
      link_to t("helpers.lessons_helper.button_start"),
        category_lessons_path(lesson.category, lesson),
          class: "btn btn-primary"
    when "finished"
      link_to t("helpers.lessons_helper.button_view"),
        category_lessons_path(lesson.category, lesson),
          class: "btn btn-success"
    else
      link_to t("helpers.lessons_helper.button_continue"),
        category_lessons_path(lesson.category,
          lesson), class: "btn btn-info"
    end
  end

  def status_field lesson
    case lesson.status
    when "init"
      label :status, t("helpers.lessons_helper.status_new"),
        class: "label label-primary"
    when "finished"
      label :status, t("helpers.lessons_helper.status_finished"),
        class: "label label-success"
    else
      label :status, t("helpers.lessons_helper.status_in_progress"),
        class: "label label-info"
    end
  end

  def spent_time_field lesson
    if lesson.spent_time.nil?
      "00:00:00"
    else
      minutes = (lesson.spent_time/60).to_i
      seconds = lesson.spent_time - minutes*60
      "#{minutes} : #{seconds}"
    end
  end

  def score_field lesson
    if lesson.score.nil?
      "-/-"
    end
  end
end

module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.applications_helper.fels215"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |build|
      render "admin/words/answer_field", f: build
    end
    link_to name, "#", class: "add-fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end
end

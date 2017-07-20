module ApplicationHelper
  def errors_for(model)
    unless model.errors.empty?
      content_tag :div, model.errors.full_messages.join(', ')
    end
  end

end

module ProjectsHelper

  def end_date_for(project)
    if project.end_date.nil?
      "-"
    else
      l project.end_date, format: :long
    end
  end

  def end_date_full_for(project)
    html = end_date_for(project)
    if !project.end_date.nil?
      html = '<i class="icon popup calendar"></i> ' + html
    end
    html.html_safe
  end

  def status_for(project)
    html = ""
    if project.is_closed
      html = '<span class="popup" data-html="Ce projet est <b>fermé</b> et n\'accepte pas les réponses"><span class="ui red empty circular label"></span></span>'
    else
      if project.end_date.nil?
        html = '<span class="popup" data-html="Ce projet est <b>ouvert</b> et accepte les réponses"><span class="ui green empty circular label"></span></span>'
      else
        html = '<span class="popup" data-html="Ce projet est <b>ouvert</b> et accepte les réponses"><span class="ui green empty circular label"></span></span> <i class="icon popup calendar" data-html="' + 'La <b>fermeture automatique</b> aura lieu le :<br />' + end_date_for(project) + '"></i>'
      end
    end
    html.html_safe
  end

  def status_full_for(project)
    html = ""
    if project.is_closed
      html = '<span class="ui red empty circular label"></span> <span>Ce projet est <b>fermé</b> et n\'accepte pas les réponses</span>'
    else
      if project.end_date.nil?
        html = '<span class="ui green empty circular label"></span> <span>Ce projet est <b>ouvert</b> et accepte les réponses</span>'
      else
        html = '<span class="ui green empty circular label"></span> <span>Ce projet est <b>ouvert</b> et accepte les réponses</span>'
      end
    end
    html.html_safe
  end

  def dropdown_for_order_by(order_by_possible_values, order_by_selected_value)
    hint_text = order_by_possible_values[order_by_selected_value]
    active_class = 'active selected'

    html = <<-HTML
      <div class="ui fluid projects_order selection dropdown"> Ordonner :
        <div class="text">#{hint_text}</div>
        <input type="hidden" name="order_by">
        <i class="dropdown icon"></i>
        <div class="menu">
    HTML

    order_by_possible_values.each do |data_value, description|
      if data_value == 'divider'
        html += '<div class="divider"></div>'
      else
        html += '<div class="item '
        if data_value == order_by_selected_value
          html +=active_class
        end
        html += '" data-value="' + data_value + '">' + description + '</div>'
      end
    end

    html += '</div></div>'
    html.html_safe
  end

end

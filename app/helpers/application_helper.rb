module ApplicationHelper
  def flash_messages
    html = ""
    if notice
      html = <<-HTML
      <div class="ui success message container">
        <i class="close icon"></i>
        #{notice}
      </div>
      HTML
    end
    if alert
      html = <<-HTML
      <div class="ui error message container">
        <i class="close icon"></i>
        #{alert}
      </div>
      HTML
    end
    html.html_safe
  end

  def form_error_messages_for(resource)
    html = ""
    if resource.errors.any?
      title = pluralize(resource.errors.count, "erreur", "erreurs") + " " + "détectée".pluralize(resource.errors.count)
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

      html = <<-HTML
      <div class="ui error message container">
        <i class="close icon"></i>
        <div class="title">#{title}</div>
        <ul>
          #{messages}
        </ul>
      </div>
      HTML
    end
    html.html_safe
  end
end

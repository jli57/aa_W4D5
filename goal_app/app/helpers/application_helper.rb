module ApplicationHelper
  def auth_token
    html = <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end

  def errors
    return "" if flash[:errors].nil? || flash[:errors].empty?
    html = '<ul class="errors">'
    flash[:errors].each do |error|
      html += "<li>#{error}</li>"
    end
    html += '</ul>'
    html.html_safe
  end
end

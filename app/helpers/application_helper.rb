module ApplicationHelper
  def resource_name
    :user
  end

  def resource_class
     User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Added this so you can use markdown when editing the front page
  # This is just using the RedCarpet gem to parse basic text
  # and turn it into HTML
  def markdown(content)
    # renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(content).html_safe
  end
end

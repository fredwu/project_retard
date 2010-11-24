module ApplicationHelper
  # converts the string to HTML via MarkDown
  #
  # @param [String] str
  def markdownize(str, options={})
    return str if str.blank?

    options = { :sanitize => true }.merge(options)
    html    = RDiscount.new(str, :autolink).to_html

    options[:sanitize] ? Sanitize.clean(html, Sanitize::Config::RELAXED).html_safe : html.html_safe
  end

  # renders the default errors block in forms
  #
  # @param [Object] resource ActiveRecord object
  def display_errors!(resource)
    html = []
    if resource.errors.any?
      html << "<div class='message errormsg nohide'>"
      html << "<h2>#{pluralize(resource.errors.count, 'error')} found:</h2>"
      html << "<ul>"
      resource.errors.full_messages.each do |msg|
        html << "<li>#{msg}</li>"
      end
      html << "</ul>"
      html << "</div>"
    end
    html.join("\n").html_safe
  end

  # renders a block with some default structrual HTML
  #
  # @param [Hash] options
  # @param [Block] block HTML content that goes into the block
  def render_block(options = {}, &block)
    options.merge!(:content => capture(&block))
    options = {
      :layout  => "layouts/block",
      :classes => ""
    }.merge(options)
    render :partial => options[:layout], :locals => options
  end

  # a shortcut for ajaxified link_to
  #
  # @param [String] label link_to() label
  # @param [Object] resource target resource
  # @param [Hash] options
  # @return [String]
  def link_to_ajax(label, resource, options={})
    options.key?(:class) ? options[:class] << " ajaxify" : options[:class] = "ajaxify"

    link_to(label, resource, options)
  end

  # set up the destroy action for use with jQuery Inline Confirmation
  #
  # @param [String] label link_to() label
  # @param [Object] resource target resource
  # @param [Hash] options
  def link_to_deletion(label, resource, options={})
    options = {
      :class => "del-resource",
      :"data-id" => resource.id
    }.merge(options)

    link_to(label, options[:url] || resource, options)
  end

  # removes :controller and :action elements so that the params can be passed on
  #
  # @return [Hash]
  def keep_params
    params.delete(:controller)
    params.delete(:action)
    params.delete(:page)
    params
  end

  # outputs "Yes" or "No"
  #
  # @param [Mixed] attribute
  # @return [String]
  def yes_or_no?(attribute)
    if attribute.respond_to?(:any?)
      attribute.any? ? "Yes" : "No"
    else
      attribute ? "Yes" : "No"
    end
  end
end

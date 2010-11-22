module ColoursHelper
  def show_swatches(product)
    html = []
    html << "<ul id='swatches'>"
    product.colours.uniq.each do |colour|
      html << "<li><a href='#' style='background: ##{colour.hex}' title='#{colour.name.titleize}' data-id='#{colour.id}'></a></li>"
    end
    html << "</ul>"
    html.join("\n").html_safe
  end
end

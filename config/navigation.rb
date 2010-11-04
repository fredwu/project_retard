# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'active'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |menu|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #
    # Add an item which has a sub navigation (same params, but with block)
    menu.item :products, "Products", products_path do |products|
      products.item :products_new, "Add New Product", new_product_path
    end

    menu.item :colours, "Colours", colours_path do |sizes|
      sizes.item :colours_new, "Add New Colour", new_colour_path
    end

    menu.item :sizes, "Sizes", sizes_path do |sizes|
      sizes.item :sizes_new, "Add New Size", new_size_path
    end

    menu.item :orders, "Orders", orders_path do |orders|
      orders.item :orders_new, "New Orders", orders_path
      orders.item :orders_fullfied, "Fullfied Orders", orders_path
    end

    menu.item :retailers, "Retailers", retailers_path do |retailers|
      retailers.item :retailers_new, "Add New Retailer", new_retailer_path
    end

    menu.item :users, "Users", users_path

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    # primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    # primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    menu.dom_id = 'nav'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end

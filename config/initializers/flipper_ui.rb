require "flipper/ui"
require "flipper/adapters/active_record"

Flipper::UI.configure do |config|
  # config.descriptions_source = lambda { |keys|
  #   descriptions loaded from YAML file or database (postgres, mysql, etc)
  #   return has to be hash of {String key => String description}
  # }

  # Defaults to false. Set to true to show feature descriptions on the list
  # page as well as the view page.
  # config.show_feature_description_in_list = true
end

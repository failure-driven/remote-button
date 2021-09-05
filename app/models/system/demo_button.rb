module System
  module DemoButton
    # a default demo button to display on the site

    TEMPLATES = {
      demo_button: {
        # Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, 'demo-button')
        id: "a80ff544-34e2-5d3f-a18c-7412f18e99f0",
        email: Rails.configuration.demo_button[:email],
        site: Rails.configuration.demo_button[:site],
        external_reference: "000000000000".upcase.scan(/../).join(":"),
      },
    }.freeze

    def self.create_or_update(model_class, attributes)
      if (model = model_class.find_by(id: attributes[:id]))
        model.attributes = model.attributes.merge(attributes.without(:id))
        model.save! if model.changed?
        model
      else
        model_class.create!(attributes)
      end
    end

    def self.setup
      create_or_update(::Button, TEMPLATES[:demo_button])
    end
  end
end

module System
  module Mode
    # include Resource

    TEMPLATES = {
      mode: {
        counter: {
          # require 'active_support/core_ext/digest/uuid'
          # Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, 'remote-button-mode-counter')
          id: "05762f12-db48-50a4-84b8-dd965ca8fedc".freeze,
          name: "Counter",
          properties: {
            reports: [
              {
                name: "target",
                template: "counter_target_bar_graph",
              },
              {
                name: "Activity time tracker",
                template: "counter_activity_time_tracker",
                report_generator: "counter_activity_time_tracker"
              },
              {
                name: "Total count",
                template: "total_count",
                report_generator: "total_count",
              },
              {
                name: "Days active",
                template: "days_active",
                report_generator: "activity_by_day",
              },
              {
                name: "Activity spread analysis",
                template: "counter_activity_spread_analysis",
              },
              {
                name: "Motivational quotes",
                template: "motivational_quotes",
              },
              {
                name: "Gauge dashboard",
                template: "gauge_dashboard",
              },
            ],
          },
        },
        reaction: {
          # Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, 'remote-button-mode-reaction')
          id: "6e299d16-2a67-5e94-a820-40e3caa42da6".freeze,
          name: "Reaction",
          properties: {
            reports: [
              {
                name: "Overall Average Reaction",
                template: "reaction_overall_average",
              },
              {
                name: "Motivational quotes",
                template: "motivational_quotes",
              },
              {
                name: "Total count",
                template: "total_count",
              },
              {
                name: "Days active",
                template: "days_active",
              },
              {
                name: "Activity time tracker",
                template: "counter_activity_time_tracker",
              }
            ],
          },
        },
      }.freeze,
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

    def self.setup_modes
      create_or_update(::Mode, TEMPLATES[:mode][:counter])
      create_or_update(::Mode, TEMPLATES[:mode][:reaction])
    end
  end
end

def create_or_update(model_class, attributes)
  if (model = model_class.find_by(id: attributes[:id]))
    model.attributes = model.attributes.merge(attributes.without(:id))
    model.save! if model.changed?
    model
  else
    model_class.create!(attributes)
  end
end

desc "fake data"
task fake_data: :environment do
  include Rails.application.routes.url_helpers

  [
    {
      email: "solid_10_in_morning@button.com",
      buttons: [
        button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-solid_10_in_morning"),
      ],
      events: lambda { |button|
                return if button.events.count >= 365 * 100

                ((Date.today - 1.year)..Date.today).each do |date|
                  hour_offset = 9.hours
                  (0..18).step(2).each do |minute_offset|
                    (0..9).each do |second_offset|
                      button
                        .events
                        .create(
                          created_at: date.to_datetime + hour_offset + minute_offset.minutes + second_offset.seconds,
                        )
                    end
                  end
                end
              },
    },
    {
      email: "random_10_sets_every_4_days_or_so@button.com",
      buttons: [
        button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-random_10_sets_every_4_days_or_so"),
      ],
      events: lambda { |button|
                button.events.delete_all
                every_4_days_or_so = ((Date.today - 3.months)..Date.today).map { |date| date + rand(4).days }
                every_4_days_or_so.each do |date|
                  hour_offset = rand(7..22).hours # between 7am and 11pm
                  minute_offset = rand(30).minutes # between on the hour to half past the hour
                  second_offset = 0
                  (0..(rand(5..54))).each do |_pushups| # between 5 and 55 pushups
                    second_offset += rand(10).seconds # between 0 and 10 seconds per pushup
                    button
                      .events
                      .create(
                        created_at: date.to_datetime + hour_offset + minute_offset + second_offset,
                      )
                  end
                end
              },
    },
    {
      email: "all_day_workout_au@button.com",
      buttons: [
        button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_day_workout_au"),
      ],
    },
    {
      email: "all_day_workout_uk@button.com",
      buttons: [
        button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_day_workout_uk"),
      ],
    },
    {
      email: "all_the_buttons@button.com",
      buttons: [
        { button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_the_buttons_01") },
        { button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_the_buttons_02") },
        { button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_the_buttons_03") },
        { button_id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "fake-button-all_the_buttons_04") },
      ],
    },
  ].each do |setup_data|
    setup_data[:buttons].each do |button|
      button = create_or_update(
        ::Button, {
          id: button[:button_id],
          email: setup_data[:email],
          site: "http://localhost:3000",
          external_reference: "00:00:00:00:00:00",
        },
      )
      setup_data[:events]&.call(button)
      puts button.email
      puts mode_report_button_url(button)
      puts
    end
  end
end

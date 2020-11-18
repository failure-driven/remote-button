require "rails_helper"
require "pry"

feature "Navigation", js: true do
  scenario "Pagination of raw results" do
    Given "Sam is visiting at 9 o'clock on a saturday" do
      travel_to Time.iso8601("2020-11-14T21:00:00")
      @button = Button.create!(
        email: "m@m.m",
        site: "site.com",
        external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
      )
      100.times do
        @button.events.create
      end
      visit report_button_path(@button)
    end

    Then "Sam sees 25 events" do
      pending "work out why 31 events per page"
      wait_for do
        page.find_all("section[data-testid=\"events\"] li").count
      end.to eq 25
    end
  end
end

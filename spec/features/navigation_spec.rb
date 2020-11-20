require "rails_helper"

feature "Navigation", js: true do
  scenario "Pagination of raw results" do
    Given "Sam is visiting at 9 o'clock on a saturday" do
      travel_to Time.iso8601("2020-11-14T21:00:00")
      @button = Button.create!(
        email: "m@m.m",
        site: "site.com",
        external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
      )
      98.times do
        @button.events.create
      end
      visit report_button_path(@button)
    end

    Then "Sam sees 25 events" do
      wait_for do
        focus_on(:software_button).count
      end.to eq 25
    end

    Then "Sam goes to the page 2, he sees 25 events" do
      click_on "2"
      wait_for do
        focus_on(:software_button).count
      end.to eq 25
    end

    Then "Sam goes to the page 4, he sees 23 events" do
      click_on "4"
      wait_for do
        focus_on(:software_button).count
      end.to eq 23
    end
  end
end

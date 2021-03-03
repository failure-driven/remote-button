require "rails_helper"

feature "Button modes", js: true do
  scenario "Default mode" do
    Given "Sam is visiting at 9 o'clock on a saturday" do
      travel_to Time.iso8601("2020-11-14T21:00:00")
      @button = create(:button)
      visit button_path(@button)
    end

    When "Sam registers a set of 10 push ups at 9pm" do
      focus_on(:software_button).click(number_of_times: 10, every: 2.seconds)
    end

    And "another 10 at 9:10pm" do
      # wait for last button press to complete before bumping time
      wait_for { page.find("button", text: "Button")["disabled"] }.to eq("false")
      travel_to Time.iso8601("2020-11-14T21:10:00")
      focus_on(:software_button).click(number_of_times: 10, every: 2.seconds)
    end

    And "another 10 at 10am on Sunday, the next week" do
      # wait for last button press to complete before bumping time
      wait_for { page.find("button", text: "Button")["disabled"] }.to eq("false")
      travel_to Time.iso8601("2020-11-22T13:00:00")
      focus_on(:software_button).click(number_of_times: 10, every: 2.seconds)
    end

    Then "Sam sees a report of 2 sets on Saturday and 1 set on Sunday" do
      click_on "raw report"
      wait_for do
        focus_on(:report).report_totals
      end.to eq("30 total events have been recorded")

      wait_for do
        focus_on(:report).report_daily_totals
      end.to contain_exactly(
        "2020-11-22: 10",
        "2020-11-14: 20",
      )
    end
  end
end

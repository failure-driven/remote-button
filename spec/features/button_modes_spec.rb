require "rails_helper"

feature "Button modes", js: true do
  scenario "Default mode" do
    Given "Sam is visiting at 9 o'clock on a saturday" do
      travel_to Time.iso8601("2020-11-14T21:00:00")
      @button = Button.create!(
        email: "m@m.m",
        site: "site.com",
        external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
      )
      visit button_path(@button)
    end

    When "Sam registers a set of 10 push ups at 9pm" do
      10.times do
        page.within("section[data-testid=\"software-button\"]") do
          click_on "Button"
          wait_for do
            page.find("section[data-testid=\"software-button\"] button")[:disabled]
          end.to eq "false"
          travel_to Time.now + 2.seconds
        end
      end
    end

    And "another 10 at 9:10pm and another at 9:22pm" do
      travel_to Time.iso8601("2020-11-14T21:10:00")
      10.times do
        page.within("section[data-testid=\"software-button\"]") do
          click_on "Button"
          wait_for do
            page.find("section[data-testid=\"software-button\"] button")[:disabled]
          end.to eq "false"
          travel_to Time.now + 2.seconds
        end
      end

      travel_to Time.iso8601("2020-11-14T21:22:00")
      10.times do
        page.within("section[data-testid=\"software-button\"]") do
          click_on "Button"
          wait_for do
            page.find("section[data-testid=\"software-button\"] button")[:disabled]
          end.to eq "false"
          travel_to Time.now + 2.seconds
        end
      end
    end

    And "another 10 at 10am on Sunday, the next day" do
      travel_to Time.iso8601("2020-11-15T10:00:00")
      10.times do
        page.within("section[data-testid=\"software-button\"]") do
          click_on "Button"
          wait_for do
            page.find("section[data-testid=\"software-button\"] button")[:disabled]
          end.to eq "false"
          travel_to Time.now + 2.seconds
        end
      end
    end

    Then "Sam sees a report of 3 sets on Saturday and 1 set on Sunday" do
      click_on "raw report"
      pending "an actual report section with report on it"
      wait_for do
        page.find_all("section[data-testid=\"report\"]")
      end.to eq("3 sets of 10 on Saturday and 1 set of 10 on a Sunday")
    end
  end
end

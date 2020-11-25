module PageFragments
  module SoftwareButton
    def click(number_of_times:, every:)
      number_of_times.times do
        browser.within("section[data-testid=\"software-button\"]") do
          browser.click_on "Button"
          browser.synchronize do
            browser.find("section[data-testid=\"software-button\"] button")[:disabled] == "false"
          end
          browser.travel_to Time.now + every
        end
      end
    end

    def count
      browser.find_all("section[data-testid=\"events\"] .list-group-item").size
    end

    def name
      browser.find("section[data-testid=\"button-name\"]").text
    end
  end
end

module PageFragments
  module SoftwareButton
    def click(number_of_times:, every:)
      number_of_times.times do
        browser.within("section[data-testid=\"software-button\"]") do
          browser.click_on "Button"
          # TODO: add back in
          # browser.wait_for do
          #   browser.find("section[data-testid=\"software-button\"] button")[:disabled]
          # end.to eq "false"
          browser.travel_to Time.now + every
        end
      end
    end

    def count
      browser.find_all("section[data-testid=\"events\"] .list-group-item").size
    end
  end
end

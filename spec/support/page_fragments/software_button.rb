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

    def count(test_id_value)
      browser.find_all("section[data-testid=\"#{test_id_value}\"] .list-group-item").size
    end

    def click_list_item
      browser.find_all("div[class=\"col button-link\"]").first.text
    end

    def name
      browser.find("section[data-testid=\"button-name\"]").text
    end

    def rename(new_name)
      browser.within("form[data-testid=\"update_name_form\"]") do
        browser.fill_in "Name", with: new_name
        browser.click_on "update name"
      end
    end
  end
end

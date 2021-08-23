module PageFragments
  module SoftwareButton
    def click(number_of_times:, every:)
      number_of_times.times do
        page.within("section[data-testid=\"software-button\"]") do
          page.click_on "Button"
          page.synchronize do
            page.find("section[data-testid=\"software-button\"] button")[:disabled] == "false"
          end
          page.travel_to Time.now + every
        end
      end
    end

    def count(test_id_value)
      page.find_all("section[data-testid=\"#{test_id_value}\"] .list-group-item").size
    end

    def count_cards
      page.find_all("section[data-testid=\"buttons\"] .card").size
    end

    def click_list_item
      page.find_all("[class=\"button-link btn btn-primary\"]").first.text
    end

    def name
      page.find("section[data-testid=\"button-name\"]").text
    end

    def rename(new_name)
      page.within("form[data-testid=\"update_name_form\"]") do
        page.fill_in "Name", with: new_name
        page.click_on "update name"
      end
    end
  end
end

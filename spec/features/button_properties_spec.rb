require "rails_helper"

feature "Button properties", js: true do
  scenario "renaming button" do
    Given "Sam has a button which has no name" do
      # travel_to Time.iso8601("2020-11-23T21:00:00")
      travel_to Time.now
      @button = Button.create!(
        email: "m@m.m",
        site: "site.com",
        external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
      )
      visit button_path(@button)
    end

    When "Sam clicks edit they can remae the button" do
      visit edit_button_path(@button)
      fill_in "Name", with: "First Button"
      click_on "update name"
      visit button_path(@button)
      wait_for do
        focus_on(:software_button).name
      end.to eq("First Button")
    end

    # Then "Sam sees that the button's name changed on the page" do
    #   # code here
    # end
  end
end

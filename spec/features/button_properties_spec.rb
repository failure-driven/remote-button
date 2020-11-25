require "rails_helper"

feature "Button properties", js: true do
  scenario "renaming button" do
    Given "Sam has a button which has no name" do
      travel_to Time.now
      @button = Button.create!(
        email: "m@m.m",
        site: "site.com",
        external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
      )
      visit button_path(@button)
    end

    When "Sam attempts to rename the button" do
      page.within("[data-testid=\"button-actions\"]") do
        click_on "Change name"
      end

      focus_on(:software_button).rename("First Button")

      visit button_path(@button)
      wait_for do
        focus_on(:software_button).name
      end.to eq("First Button")
    end
  end

  # scenario "Viewing all buttons belonging to one email" do
  #   Given "Sam has two buttons registered with the same email" do
  #     travel_to Time.iso8601("2020-11-23T21:00:00")
  #     @button_1 = Button.create!(
  #       email: "m@m.m",
  #       site: "site.com",
  #       external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
  #       )
  #     travel_to Time.now
  #     @button_2 = Button.create!(
  #       email: "m@m.m",
  #       site: "site.com",
  #       external_reference: SecureRandom.hex(6).upcase.scan(/../).join(":"),
  #       )
  #       visit button_path(@button_2)
  #   end

  #   When "Sam clicks show all they see all their buttons" do
  #     # visit all my buttons page\
  #     visit all_my_buttons_path
  #     # list contains two buttons
  #     # Sam can click on them and then it take them to that button's page
  #   end
  # end
end

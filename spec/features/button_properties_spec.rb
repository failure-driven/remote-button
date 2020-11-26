require "rails_helper"

FactoryBot.define do
  factory :button do
    email { "m@m.m" }
    site  { "site.com" }
    external_reference { SecureRandom.hex(6).upcase.scan(/../).join(":") }
    id { SecureRandom.uuid }
  end
end

feature "Button properties", js: true do
  scenario "renaming button" do
    Given "Sam has a button which has no name" do
      @button = create(:button)
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

  scenario "Viewing all buttons belonging to one email" do
    Given "Sam has two buttons registered with the same email" do
      @button1 = create(:button)
      @button2 = create(:button)
      visit button_path(@button2)
    end

    When "Sam clicks show all they see all their buttons" do
      click_on "All my buttons"
      wait_for do
        focus_on(:software_button).count("buttons")
      end.to eq 3
    end

    # When "Sam clicks show all they see all their buttons" do
    #   # Sam can click on them and then it take them to that button's page
    # end
  end
end

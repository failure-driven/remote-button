require "rails_helper"

feature "It works", js: true do
  scenario "I have rails" do
    When "user visits the app" do
      visit root_path
    end

    Then "user sees they are on rails" do
      wait_for { focus_on(:welcome).message_and_versions }.to include(
        message: "Yay! You’re on Rails!",
        rails_version: match(/^6.0.3.4/),
        ruby_version: match(/^ruby 2.7.1/),
      )
    end
  end
end
require "rails_helper"

feature "landing page", js: true do
  scenario "heading and image of a remote button" do
    When "user visits the landing page" do
      visit root_path
    end

    Then "the see the remote button heading and image" do
      wait_for { page.find("h1").text.strip }.to eq "DYNAMIC BUTTON"
      wait_for do
        page.find("[data-testid=\"remote-button-image\"]")["alt"]
      end.to eq "Remote Button"
    end
  end
end

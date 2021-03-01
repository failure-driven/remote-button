require "rails_helper"

feature "Bootstrap and signup", js: true do
  scenario "Melanie from Canva gets accepted to the button beta program" do
    When "Melanie goes to the remote button site" do
      visit root_path
    end

    And "signs up" do
      find("form#new_user").fill_in("Email", with: "melanie.perkins@canva.com")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she is prompted to check her email" do
      wait_for do
        find(".alert span").text
      end.to eq "A message with a confirmation link has been sent to your email address." \
       " Please follow the link to activate your account."
    end

    When "she accepts the link in the email" do
      open_email "melanie.perkins@canva.com"
      current_email.click_link "CONFIRM MY ACCOUNT"
    end

    Then "she sees she has successfully confirmed her account" do
      wait_for do
        find(".alert span").text
      end.to eq "Your email address has been successfully confirmed."

      pending "an initial sign up specific header"

      wait_for do
        page.find_all("nav .nav-link").map(&:text)
      end.to contain_exactly(
        "melanie.perkins@canva.com",
        "Sign out",
      )
    end

    And "she needs to wait to be accepted in the beta program" do
      wait_for do
        page.text
      end.to include "We hope you will shortly be accepted in to our beta program"
    end
  end
end

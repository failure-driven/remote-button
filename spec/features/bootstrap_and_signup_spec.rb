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

      wait_for do
        page.find_all("nav .nav-link").map(&:text)
      end.to contain_exactly(
        "Build",
        "Contact",
        "Guide",
        "Register\n(current)",
        "Server",
        "melanie.perkins@canva.com",
        "Sign out",
      )
    end

    And "she needs to wait to be accepted in the beta program" do
      wait_for do
        page.text
      end.to include "We hope you will shortly be accepted into our beta program"
    end

    When "she signs out" do
      page.find("nav .nav-link", text: "Sign out").click
      wait_for do
        find(".alert span").text
      end.to eq "Signed out successfully."
    end

    And "signs in again" do
      find("form#new_user").fill_in("Email", with: "melanie.perkins@canva.com")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she can use the form to sign in via email token" do
      pending "make passwodless login work"
      # HINT: create a passwordless sign in email with a reset_token = user.send(:set_reset_password_token)
      #       and a passwodless#login function with
      #         user = User.with_reset_password_token(params[:reset_token]
      #         sign_in user
      wait_for do
        find(".alert span").text
      end.to eq "A message with a login link has been sent to your email address."
      open_email "melanie.perkins@canva.com"
      current_email.click_link "LOGIN TO MY ACCOUNT"
      wait_for do
        find(".alert span").text
      end.to eq "You have logged in via email link."
      wait_for do
        page.find_all("nav .nav-link").map(&:text)
      end.to contain_exactly(
        "melanie.perkins@canva.com",
        "Sign out",
      )
    end
  end

  scenario "remote button admin Lara Setrakian administers some users" do
    Given "Lara Setrakian from Newsdeeply fame joins the button team as an admin" do
      # HINT: create user email: "lara.setrakian@newsdeeply.com" or something similar
    end

    When "Lara goes to administer the site" do
      visit admin_users_path
    end

    Then "she is told to log in" do
      pending "having authentication on admin"

      # HINT: look at admin/application_controller and work out devise authentication
      wait_for do
        find(".alert span").text
      end.to eq "You need to sign in or sign up before continuing."
    end

    When "she logs in and goes to administer the site" do
      # HINT: you may need to create a confirmed user in the Given block above and make sure the test
      #       passwords match
      find("form#new_user").fill_in("Email", with: "lara.setrakian@newsdeeply.com")
      find("form#new_user").fill_in("Password", with: "1password")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she is told she needs admin priveledges" do
      # HINT: authenticate and authorize admin in admin/application_controller
      wait_for do
        find(".alert span").text
      end.to eq "You are not authorized to do that."
    end

    When "she finally logs in with admin priveledges" do
      # HINT: do something to the Lara User model to make it authorized
      #       User.find_by(email: "lara.setrakian@newsdeeply.com").auhtorize...
      find("form#new_user").fill_in("Email", with: "lara.setrakian@newsdeeply.com")
      find("form#new_user").fill_in("Password", with: "1password")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she sees there are no users registered" do
      wait_for do
        page.find_all("tbody tr")
      end.to be_empty # actually she will be a user there
    end

    When "2 other users sign up" do
      # sign out as Lara
      page.find(".navigation a", text: "Back to app").click
      page.find("nav .nav-link", text: "Sign out").click

      # HINT: this could go in a page fragment or a macro that calls a number of page fragments
      # sign up as Carly
      find("form#new_user").fill_in("Email", with: "carly.zakin@the.skimm.com")
      find("form#new_user").find('input[type="submit"]').click
      open_email "carly.zakin@the.skimm.com"
      current_email.click_link "CONFIRM MY ACCOUNT"
      page.find("nav .nav-link", text: "Sign out").click

      # sign up as Jocelyn
      find("form#new_user").fill_in("Email", with: "jocelyn.leavitt@hopscotch.com")
      find("form#new_user").find('input[type="submit"]').click
      open_email "jocelyn.leavitt@hopscotch.com"
      current_email.click_link "CONFIRM MY ACCOUNT"
      page.find("nav .nav-link", text: "Sign out").click
    end

    And "Lara logs in again" do
      visit admin_users_path
      find("form#new_user").fill_in("Email", with: "lara.setrakian@newsdeeply.com")
      find("form#new_user").fill_in("Password", with: "1password")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she can see the new sign ups" do
      keys = page.find_all("thead tr th").map(&:text)
      wait_for do
        page
          .find_all("tbody tr")
          .map { |tr| keys.zip(tr.find_all("td").map(&:text)).to_h.slice("Email") }
      end.to contain_exactly(
        { "Email" => "lara.setrakian@newsdeeply.com" },
        { "Email" => "carly.zakin@the.skimm.com" },
        { "Email" => "jocelyn.leavitt@hopscotch.com" },
      )
    end
  end

  scenario "some users are invited to the beta" do
    When "Gina Trapani from Lifehacker signs up" do
      visit root_path
      find("form#new_user").fill_in("Email", with: "gina.trapani@lifehacker.com")
      find("form#new_user").find('input[type="submit"]').click
      open_email "gina.trapani@lifehacker.com"
      current_email.click_link "CONFIRM MY ACCOUNT"
    end

    Then "she sees she is not yet part of the beta and signs out" do
      wait_for do
        find(".alert span").text
      end.to eq "Your email address has been successfully confirmed."
      wait_for { page.text }.to include "not part of beta yet"
      page.find("nav .nav-link", text: "Sign out").click
    end

    When "Pooja Sankar from Piazza signs up" do
      find("form#new_user").fill_in("Email", with: "pooja.sankar@piazza.com")
      find("form#new_user").find('input[type="submit"]').click
      open_email "pooja.sankar@piazza.com"
      current_email.click_link "CONFIRM MY ACCOUNT"
    end

    Then "she sees she is not yet part of the beta and signs out" do
      wait_for do
        find(".alert span").text
      end.to eq "Your email address has been successfully confirmed."
      wait_for { page.text }.to include "not part of beta yet"
      page.find("nav .nav-link", text: "Sign out").click
    end

    When "an admin invites Gina to the beta" do
      # HINT: this will break when an admin needs authorization
      visit admin_users_path
      page.find("td", text: "gina.trapani@lifehacker.com").click
      page.find(".form-actions a", text: "Send Beta Invitation Email").click
    end

    And "Gina clicks on the accept beta invitation link" do
      open_email "gina.trapani@lifehacker.com"
      current_email.click_link "ACCEPT BETA"
    end

    Then "she is logged in" do
      wait_for do
        find(".alert span").text
      end.to eq "Congratulations you are now part of the Button Beta."

      wait_for do
        page.find_all("nav .nav-link").map(&:text)
      end.to contain_exactly(
        "Build",
        "Contact",
        "Guide",
        "Register\n(current)",
        "Server",
        "gina.trapani@lifehacker.com",
        "Sign out",
      )
    end

    And "she sees she is part of the beta and signs out" do
      wait_for { page.text }.to include "you are part of the Beta"
      page.find("nav .nav-link", text: "Sign out").click
    end

    When "Pooja visits again" do
      find("form#new_user").fill_in("Email", with: "pooja.sankar@piazza.com")
      find("form#new_user").find('input[type="submit"]').click
      page.find("form#new_user").sibling("a", text: "Log in").click
    end

    And "goes through resetting her password" do
      page.find("a", text: "Forgot your password?").click
      page.find("form#new_user").fill_in("Email", with: "pooja.sankar@piazza.com")
      find("form#new_user").find('input[type="submit"]').click
      open_email "pooja.sankar@piazza.com"
      current_email.click_link "Change my password"
      find("form#new_user").fill_in("New password", with: "1password")
      find("form#new_user").fill_in("Confirm new password", with: "1password")
      find("form#new_user").find('input[type="submit"]').click
    end

    Then "she is logged in successfully" do
      wait_for do
        find(".alert span").text
      end.to eq "Your password has been changed successfully. You are now signed in."
    end

    And "she sees she is still not part of the beta" do
      wait_for { page.text }.to include "not part of beta yet"
    end
  end
end

require "rails_helper"

feature "Register Button and view results from pressing it", js: true do
  scenario "User registers a button and clicks it" do
    Given "Sam is visiting at 9 o'clock on a saturday" do
      travel_to Time.iso8601("2020-11-14T21:00:00")
    end

    When "Sam visits the remote button site" do
      visit root_path
    end

    Then "Sam sees all the related information about the fine product" do
      # not really worth testing all the things just yet
    end

    When "Sam decides to check out the software button" do
      page.find("[data-testid=\"try-software-button-action\"]").click
    end

    And "registers a new software button" do
      fill_in "Email", with: "sam@button.com"
      fill_in "Site", with: Capybara.current_session.server.base_url
      fill_in "SSID", with: "home-ssid"
      fill_in "Password", with: "home-ap-password"
      click_on "register"
    end

    Then "Sam sees a success message and is on the button page" do
      wait_for do
        page.find(".alert [data-testid=\"message\"]").text
      end.to eq "Software button successfully created."
    end

    When "Sam looks at the raw report" do
      click_on "raw report"
    end

    Then "Sam sees it is empty" do
      wait_for do
        page.find("section[data-testid=\"events\"]").text
      end.to eq "this button has not yet been pressed"
    end

    When "Sam goes back to the button and clicks the software button twice, 1 minute appart" do
      page.within("nav") do
        click_on "Button"
      end
      2.times do
        page.within("section[data-testid=\"software-button\"]") do
          click_on "Button"
          wait_for do
            page.find("section[data-testid=\"software-button\"] button")[:disabled]
          end.to eq "false"
          travel_to Time.now + 1.minute
        end
      end
    end

    Then "Sam sees 2 registered events on the raw report, 1 minute appart" do
      click_on "raw report"
      wait_for do
        page.find_all("section[data-testid=\"events\"] li").map(&:text)
      end.to eq([
                  "2020-11-14 10:00:00 UTC",
                  "2020-11-14 10:01:00 UTC",
                ])
    end
    # you get an email with a link
    # http://localhost/button/uuid-code-here

    When "he follows the link from the email and completes registration of his button"
    # code: unique-button-mac-address-identifier
    # name: _________________________________
    # mode: COUNTER
    # SUBMIT

    Then "he gets a success message and a link to his button and report page"
    # you get a success message and a link to the software button
    # http://localhost/software_button/uuid-code-here
    # [PRESS]
    # and a report link
    # http://localhost/button/uuid-code-here/report
  end

  scenario "User registers a button which is already registerd"

  scenario "Software button registration fails with no email" do
    When "Sam tries to register a button but does not enter an email" do
      visit new_software_button_path
      fill_in "Email", with: ""
      fill_in "Site", with: Capybara.current_session.server.base_url
      fill_in "SSID", with: "home-ssid"
      fill_in "Password", with: "home-ap-password"
      click_on "register"
    end

    Then "Sam sees the error message fro the registration" do
      wait_for do
        page.find(".alert [data-testid=\"message\"]").text
      end.to eq "Validation failed: Email can't be blank"
    end
  end

  scenario "Hardware button sends invalid registration request" do
    When "a hardware button makes a HTTP POST to register itself" do
      uri = URI(Capybara.current_session.server.base_url)
      @response = Net::HTTP.post_form(uri, {})
    end

    Then "I get a json resonse with error and status 422 unprocessable entity" do
      wait_for { @response.code }.to eq "422"
      wait_for { JSON.parse(@response.body) }.to eq(
        {
          "error" => "Validation failed: Email can't be blank, Site can't be blank, External reference can't be blank",
        },
      )
    end
  end

  scenario "Hardware button sends valid registration request" do
    When "a hardware button makes a HTTP POST to register itself" do
      uri = URI(Capybara.current_session.server.base_url)
      @response = Net::HTTP.post_form(
        uri,
        { "button[email]" => "m@m",
          "button[site]" => Capybara.current_session.server.base_url,
          "button[external_reference]" => "1234", },
      )
    end

    Then "I get a json response with success and status 201 successfully created" do
      wait_for { @response.code }.to eq "201"
      wait_for { JSON.parse(@response.body) }.to eq(
        {
          "button_url" => "#{Capybara.current_session.server.base_url}/buttons/#{Button.first.id}",
        },
      )
    end
  end

  scenario "User attempts to register software a button with invalid input" do
    When "Sam registers a software button not filling in anything" do
      visit new_software_button_path
      click_on "register"
    end

    Then "he is show validation errors" do
      wait_for do
        page.find(".alert [data-testid=\"message\"]").text
      end.to eq "not an HTTP URI"
    end
  end
end

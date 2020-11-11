require "rails_helper"

feature "Register Button and view results from pressing it", js: true do
  scenario "User registers a button and clicks it" do
    When "Sam registers a software button" do
      visit new_software_button_path

      fill_in "Email", with: "sam@button.com"
      current_host_and_port = URI::HTTP.build(
        host: Capybara.current_session.server.host,
        port: Capybara.current_session.server.port,
      )
      fill_in "Site", with: current_host_and_port
      # fill_in "SSID", with: "home-ssid"
      # fill_in "password", with: "home-ap-password"
      fill_in "External reference", with: "default_external_reference"
      # pending "add register button to the form"
      click_on "register"

      # binding.pry # uncomment this to pause the test prior to a failure
    end

    Then "He sees a success message and recievs an email with the link"
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

    When "he visits the report page"

    Then "he sees no activity"

    When "he views the button and presses it 2 times"

    And "he visits the report page"

    Then "he sees 2 entries with time stamps"
    # pressed 8:01pm
    # pressed 8:00pm
    # < page 1, 2, 3 ...n >
  end

  scenario "User registers a button which is already registerd"
end

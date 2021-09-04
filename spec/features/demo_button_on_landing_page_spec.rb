require "rails_helper"

feature "Demo button on landing page", js: true do
  scenario "A user from the internet sees a demo button on the landing page" do
    When "A user from the internt visits the landing page" do
      page.visit root_path
    end

    Then "they see a demo button section" do
      expect(page).to have_content("Demo software button")
    end

    And "it has a title" do
      expect(focus_on(:demo_section).title).to eq "Demo software button"
    end

    And "it has a footer" do
      expect(
        focus_on(:demo_section).footer,
      ).to eq "Note: other users may be interacting with this same button and affect the outcome."
    end

    And "it has a set of modes" do
      expect(focus_on(:demo_button).modes).to contain_exactly(*%w[reflex counter timer])
    end

    And "the default mode is reflex timer" do
      expect(focus_on(:demo_button).mode).to eq("reflex")
    end

    And "the button is neutral by default" do
      expect(focus_on(:demo_button).status).to eq("neutral")
    end

    When "they hit the button" do
      focus_on(:demo_button).press
    end

    Then "it changes colour and a new reflex test begins" do
      pending "the button being pressed to put it into active mode"
      expect(focus_on(:demo_button).status).to eq("active")
      expect(focus_on(:demo_button).message).to eq("reflex test started")
    end

    When "they hit it again" do
      focus_on(:demo_button).press
    end

    Then "they get a warning too early" do
      expect(focus_on(:demo_button).message).to eq("too early")
    end

    When "they press the button to start a new reflex test" do
      focus_on(:demo_button).press
      expect(focus_on(:demo_button).message).to eq("reflex test started")
    end

    And "they wait till it changes colour before hitting it" do
      expect(focus_on(:demo_button).status).to eq("active")
    end

    Then "they are informed of their reflex speed" do
      expect(focus_on(:demo_button).message).to match(/your reflex was \d+ms/)
    end

    When "they press the button to start a new reflex test" do
      focus_on(:demo_button).press
      expect(focus_on(:demo_button).message).to eq("reflex test started")
    end

    And "allow it to time out in 4 seconds" do
      Capybara.using_wait_time(5) do # wait for 5s
        expect(page).to have_content("reflex test has timed out")
      end
    end

    Then "they are informed that the timeout was reached" do
      expect(focus_on(:demo_button).message).to eq("reflex test has timed out")
    end
  end
end
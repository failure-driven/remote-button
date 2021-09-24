require "rails_helper"

feature "Demo button on landing page", js: true do
  scenario "A user form the internet can change the demo button between various modes" do
    Given "the demo button has 3 modes" do
      page.visit root_path
      expect(focus_on(:demo_button).modes).to contain_exactly(*%w[reflex counter timer])
    end

    And "the default mode is set to reflex timer" do
      expect(focus_on(:demo_button).mode).to eq("reflex")
    end

    When "the user changes to counter mode" do
      focus_on(:demo_button).change_mode("counter")
    end

    Then "the selected mode is counter" do
      expect(focus_on(:demo_button).mode).to eq("counter")
      expect(focus_on(:demo_button).message).to eq("count 0")
    end

    When "they hit the button" do
      focus_on(:demo_button).press
    end

    Then "the count is incremented by 1" do
      expect(page).to have_content("count 1")
      expect(focus_on(:demo_button).message).to eq("count 1")
    end

    When "they hit the button 4 more times" do
      4.times { focus_on(:demo_button).press }
    end

    Then "the count is incremented to 5" do
      expect(page).to have_content("count 5")
      expect(focus_on(:demo_button).message).to eq("count 5")
    end

    When "they select reflex and go back to counter" do
      focus_on(:demo_button).change_mode("reflex")
      expect(focus_on(:demo_button).mode).to eq("reflex")
      focus_on(:demo_button).change_mode("counter")
      expect(focus_on(:demo_button).mode).to eq("counter")
    end

    Then "the count is still the same 5" do
      expect(focus_on(:demo_button).message).to eq("count 5")
    end
  end

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
      expect(page).to have_content("wait to turn active")
      pending "the button being pressed to put it into triggered mode"
      expect(focus_on(:demo_button).status).to eq("triggered")
      expect(focus_on(:demo_button).message).to eq("wait to turn active")
    end

    When "they hit it again" do
      focus_on(:demo_button).press
    end

    Then "they get a warning too early" do
      expect(page).to have_content("too early")
      expect(focus_on(:demo_button).message).to eq("too early")
    end

    When "they press the button to start a new reflex test" do
      focus_on(:demo_button).press
      expect(focus_on(:demo_button).message).to eq("wait to turn active")
    end

    And "they wait till it changes colour before hitting it" do
      expect(page).to have_content("reflex test started", wait: 3)
      expect(focus_on(:demo_button).status).to eq("active")
    end

    Then "they are informed of their reflex speed" do
      focus_on(:demo_button).press
      expect(focus_on(:demo_button).message).to match(/your reflex was \d+ms/)
    end

    When "they press the button to start a new reflex test" do
      focus_on(:demo_button).press
      expect(focus_on(:demo_button).message).to eq("wait to turn active")
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

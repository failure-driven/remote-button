class ActivityReminderJob < ApplicationJob
  def perform(button)
    UserMailer.with(button: button).button_registration.deliver_later
  end
end

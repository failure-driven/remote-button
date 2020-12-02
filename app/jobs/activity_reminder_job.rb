class ActivityReminderJob < ApplicationJob
  queue_as :mailer

  def perform(button)
    UserMailer.with(button: button).button_registration.deliver_later
  end
end

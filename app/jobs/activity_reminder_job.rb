class ActivityReminderJob < ApplicationJob
  queue_as :default

  def perform(id)
    UserMailer.with(button: Button.find(id)).button_registration.deliver_later
  end
end

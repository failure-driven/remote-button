class Button < ApplicationRecord
  attr_accessor :ssid, :password

  validates :email, :site, :external_reference, presence: true

  has_many :events, dependent: :delete_all

  def to_s
    external_reference
  end

  def daily_events
    events.order("date(created_at) DESC").group("date(created_at)").count
  end

  def report(report_name)
    send(report_name) if report_name
  end

  private

  def total_count
    events.count
  end

  def activity_by_day
    {
      activity: activity,
      months: activity_by_day_dates.map { |date| date.strftime("%b") }.uniq,
    }
  end

  def activity_by_day_dates
    start_date = (Date.today - 60.days).beginning_of_week(:sunday)
    (start_date..Date.today).to_a
  end

  def bucket
    max = daily_events.values.max.to_i
    (max / 3) + 1
  end

  def activity
    actual_activity = Hash[daily_events.map { |date, value| [date, value] }]
    activity_by_day_dates.map do |date|
      [
        date.to_s,
        actual_activity[date] &&
          (actual_activity[date].to_i / bucket) + 1,
        actual_activity[date].to_i,
      ]
    end
  end
end

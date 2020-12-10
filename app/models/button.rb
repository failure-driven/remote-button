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

  def counter_activity_time_tracker
    {
      morning_events: slot_time_events_day(6, 14),
      day_events: slot_time_events_day(14, 22),
      night_events: slot_time_events_night(22, 6),
    }
  end

  private

  def slot_time_events_night(start_hour, end_hour)
    events.select { |s| s.created_at.hour >= start_hour || s.created_at.hour < end_hour }.count
  end

  def slot_time_events_day(start_hour, end_hour)
    events.select { |s| s.created_at.hour >= start_hour && s.created_at.hour < end_hour }.count
  end

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

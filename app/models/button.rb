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
end

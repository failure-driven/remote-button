class Button < ApplicationRecord
  attr_accessor :ssid, :password

  validates :email, :site, :external_reference, presence: true

  has_many :events, dependent: :delete_all

  def to_s
    external_reference
  end
end

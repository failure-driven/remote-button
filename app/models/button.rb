class Button < ApplicationRecord
  validates :email, :site, :external_reference, presence: true

  has_many :events
end

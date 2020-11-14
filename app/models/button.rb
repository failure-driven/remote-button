class Button < ApplicationRecord
  validates :email, :site, :external_reference, presence: true
end

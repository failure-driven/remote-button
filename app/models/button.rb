class Button < ApplicationRecord
  validates :email, :site, presence: true
end

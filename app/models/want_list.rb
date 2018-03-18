class WantList < ApplicationRecord
  belongs_to :user
  belongs_to :card

  validates :user, :card, presence: true
end

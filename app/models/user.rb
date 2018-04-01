class User < ApplicationRecord
  ROLES = %w[admin free].freeze

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  enum role: ROLES.zip(ROLES).to_h

  validates :username, presence: true, uniqueness: true

  has_many :want_list, dependent: :destroy
  has_many :have_list, dependent: :destroy

  has_many :wanted_cards, through: :want_list, source: :card
  has_many :owned_cards, through: :have_list, source: :card
end

class User < ApplicationRecord
  ROLES = %w[admin free].freeze

  devise :database_authenticatable, :rememberable, :validatable, :registerable, :confirmable, :recoverable

  enum role: ROLES.zip(ROLES).to_h

  validates :username, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /[a-zA-Z0-9_\.]*/ }

  has_many :want_list, dependent: :destroy
  has_many :have_list, dependent: :destroy

  has_many :wanted_cards, through: :want_list, source: :card
  has_many :owned_cards, through: :have_list, source: :card

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login.present?
      where(conditions.to_h).find_by(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
    elsif conditions.key?(:username) || conditions.key?(:email)
      find_by(conditions.to_h)
    end
  end
end

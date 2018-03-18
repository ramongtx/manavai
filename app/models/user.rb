class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :want_list, dependent: :destroy
  has_many :have_list, dependent: :destroy

  has_many :wanted_cards, through: :want_list, source: :card
  has_many :owned_cards, through: :have_list, source: :card
end

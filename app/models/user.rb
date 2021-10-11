class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :last_name,  presence: true
  validates :first_name, presence: true
  validates :profile, length: { maximum: 1000 }
  has_one_attached :avatar
  has_many :applies
  has_many :joins
end

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
  has_many :messages

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字の両方を含めて入力してください'


  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字（漢字・ひらがな・カタカナ）で入力してください'} do
    validates :last_name
    validates :first_name
  end
end
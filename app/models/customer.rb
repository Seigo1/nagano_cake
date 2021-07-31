class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :address, presence: true, length: { minimum: 2,maximum: 50 }
  validates :postal_code, presence: true, length: { is: 7 }
  validates :telephone_number, presence: true, length: { minimum: 9,maximum: 12  }


  has_many :addresses, dependent: :destroy
  has_many :cart_items
  has_many :items, through: :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum is_active: { 有効: true, 無効: false }

  def active_for_authentication?
    super && (self.is_active == "有効")
  end
end

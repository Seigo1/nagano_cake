class Item < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true

  attachment :image
  belongs_to :genre
  has_many :cart_items
  has_many :customers, through: :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  def add_tax_price
    (self.price * 1.10).round
  end

  enum is_active: { 販売中: true, 販売停止中: false }
end

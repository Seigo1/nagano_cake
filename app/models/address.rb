class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true, length: { minimum: 2,maximum: 20 }
  validates :address, presence: true, length: { minimum: 2,maximum: 50 }
  validates :postal_code, presence: true, length: { is: 7 }

  def order_address
    "〒" + self.postal_code + " " + self.address + " " + self.name
  end

end

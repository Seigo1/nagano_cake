class CreateOrders < ActiveRecord::Migration[5.2]
  
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipping_cost, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamp :created_at, default: -> { "now()" }, null: false
      t.timestamp :updated_at, default: -> { "now()" }, null: false

      t.timestamps
    end
  end
end

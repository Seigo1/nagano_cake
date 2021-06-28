class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.references :item, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :making_status, default: 0, null: false
      t.timestamp :created_at, default: -> { "now()" }, null: false
      t.timestamp :updated_at, default: -> { "now()" }, null: false

      t.timestamps
    end
  end
end

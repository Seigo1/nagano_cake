class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :customer, foreign_key: true, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.timestamp :created_at, default: -> { "now()" }, null: false
      t.timestamp :updated_at, default: -> { "now()" }, null: false

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true, null: false
      t.string :name, null: false
      t.string :image_id, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamp :created_at, default: -> { "now()" }, null: false
      t.timestamp :updated_at, default: -> { "now()" }, null: false

      t.timestamps
    end
  end
end

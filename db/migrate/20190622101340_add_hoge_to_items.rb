class AddHogeToItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name,                  null: false, default: "", index: true
      t.integer :price,                null: false, index: true
      t.text :text
      t.string :condition,             null: false, default: ""
      t.integer :delivery_charge,      null: false
      t.string :delivery_method,       null: false, unique: true
      t.string :delivery_source_area,  null: false
      t.date :estimated_shipping_date, null: false
      t.integer :category,             null: false, foreign_key: true
      t.references :brand_id
      t.string :size
      t.integer :saler
      t.integer :buyer_id
      t.string :sales_status,          null: false
      t.timestamps
    end
  end
end

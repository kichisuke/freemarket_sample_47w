class AddHogeToItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name,                  null: false, default: "", index: true
      t.integer :price,                null: false, index: true
      t.text :text
      t.integer :condition,             null: false
      t.integer :delivery_charge,      null: false
      t.integer :delivery_method,       null: false
      t.integer :delivery_source_area,  null: false
      t.integer :estimated_shipping_date, null: false
      t.integer :category_id,             null: false, foreign_key: true
      t.references :brand
      t.integer :size
      t.integer :saler_id
      t.integer :buyer_id
      t.integer :sales_status,          null: false
      t.timestamps
    end
  end
end

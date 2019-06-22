class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code,           null: false, default: ""
      t.string :prefecture,            null: false, default: "", index: true
      t.string :city,                  null: false, default: ""
      t.string :street_address,        null: false, default: ""
      t.string :building
      t.string :phone_number,          null: false, unique: true
      t.references :user,              null: false, foreign_key: true
      t.timestamps
    end
  end
end

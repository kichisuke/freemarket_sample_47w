class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :prefecture_id
      t.string :city

      t.timestamps
    end
  end
end

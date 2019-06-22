class CreateCreditcards < ActiveRecord::Migration[5.0]
  def change
    create_table :creditcards do |t|
      t.integer :number,           null: false, unique:true
      t.date :expiration_month,    null: false
      t.date :expiration_year,     null: false
      t.integer :security_code,    null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateCreditcards < ActiveRecord::Migration[5.0]
  def change
    create_table :creditcards do |t|
      t.string :token,             null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end

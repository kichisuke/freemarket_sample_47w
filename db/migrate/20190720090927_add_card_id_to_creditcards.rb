class AddCardIdToCreditcards < ActiveRecord::Migration[5.0]
  def change
    add_column :creditcards, :card_id, :string, null: false
  end
end

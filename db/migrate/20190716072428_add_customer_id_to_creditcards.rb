class AddCustomerIdToCreditcards < ActiveRecord::Migration[5.0]
  def change
    add_column :creditcards, :customer_id, :string, null: false
  end
end

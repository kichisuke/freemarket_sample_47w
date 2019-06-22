class AddStatusToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :user, :references, null: false
    add_foreign_key :addresses, :users, column: :user
  end
end

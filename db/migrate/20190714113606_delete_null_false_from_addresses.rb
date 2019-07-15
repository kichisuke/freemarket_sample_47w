class DeleteNullFalseFromAddresses < ActiveRecord::Migration[5.0]
  def change
    change_column :addresses, :phone_number, :string, null: true
  end
end

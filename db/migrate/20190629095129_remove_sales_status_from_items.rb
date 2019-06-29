class RemoveSalesStatusFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :sales_status, :integer
  end
end

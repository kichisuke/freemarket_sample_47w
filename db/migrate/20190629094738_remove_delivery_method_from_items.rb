class RemoveDeliveryMethodFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :delivery_method, :integer
  end
end

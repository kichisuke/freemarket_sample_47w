class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :delivery_source_area

      t.timestamps
    end
  end
end

class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :family_name,           null: false, default: ""
      t.string :first_name,            null: false, default: ""
      t.string :family_name_kana,      null: false, default: ""
      t.string :first_name_kana,       null: false, default: ""
      t.integer :birth_year,           null: false
      t.integer :birth_month,          null: false
      t.text :profile_text
      t.references :user,              null: false, foreign_key: true
      t.timestamps
    end
  end
end

class ChangeBirthdayColumnsProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :birth_year, :integer
    remove_column :profiles, :birth_month, :integer
    add_column :profiles, :birthday, :date, :after => :first_name_kana, null: false
  end
end

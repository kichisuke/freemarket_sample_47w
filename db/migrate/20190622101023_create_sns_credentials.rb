class CreateSnsCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :sns_credentials do |t|
      t.string :provider,          unique:true
      # t.references :user,          null: false, foreign_key:true
      t.timestamps
    end
  end
end

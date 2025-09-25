class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name, null: true
      t.references :gender, null: false, foreign_key: true
      t.date :birthday, null: false
      t.integer :height, null: false
      t.decimal :weight, null: false, precision: 8, scale: 2

      t.timestamps
    end
    add_index :patients, [:first_name, :last_name, :middle_name, :birthday], unique: true, name: "index_patients_identity"
  end
end

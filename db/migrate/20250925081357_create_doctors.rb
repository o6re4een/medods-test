class CreateDoctors < ActiveRecord::Migration[8.0]
  def change
    create_table :doctors do |t|

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name

      t.timestamps
    end
    add_index :doctors, [:first_name, :last_name, :middle_name], unique: true
  end
end

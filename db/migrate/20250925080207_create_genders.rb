class CreateGenders < ActiveRecord::Migration[8.0]
  def change
    create_table :genders do |t|

      t.string :name

      t.timestamps
    end
    add_index :genders, :name, unique: true
  end
end

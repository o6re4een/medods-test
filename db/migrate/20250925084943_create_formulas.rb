class CreateFormulas < ActiveRecord::Migration[8.0]
  def change
    create_table :formulas do |t|

      t.string :name

      t.timestamps
    end
    add_index :formulas, :name
  end
end

class CreateBmrHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :bmr_histories do |t|

      t.references :patient, null: false, foreign_key: true
      t.references :formula, null: false, foreign_key: true
      t.decimal :result, precision: 6, scale: 2, null: false

      t.date :calculated_on, null: false


      t.timestamps
    end

    add_index :bmr_histories, [:patient_id, :formula_id, :calculated_on], unique: true, name: "index_bmr_on_patient_formula_date"
  end
end

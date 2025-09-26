class AddFullNamePatients < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!
  def change
    enable_extension "pg_trgm" unless extension_enabled?("pg_trgm")


    # делаем формат "имя фамилия отчество" для gin
    execute <<~SQL
      ALTER TABLE patients
      ADD COLUMN full_name TEXT GENERATED ALWAYS AS (
        lower(coalesce(first_name, '') || ' ' || coalesce(last_name, '') || ' ' || coalesce(middle_name, ''))
      ) STORED;
    SQL

    add_index :patients, :full_name, using: :gin, opclass: :gin_trgm_ops, algorithm: :concurrently
  end
  def down
    remove_index :patients, :full_name
    execute <<~SQL
      ALTER TABLE patients
      DROP COLUMN full_name;
    SQL
  end
end


class CreateDatabaseQueryAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :database_query_assignments do |t|
      t.references :database, null: false, foreign_key: true
      t.references :query, null: false, foreign_key: true

      t.timestamps
    end
  end
end

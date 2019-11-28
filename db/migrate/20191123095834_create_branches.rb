class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.references :project, null: false, foreign_key: true
      t.string :current_hash

      t.timestamps
    end

    add_index :branches, [:project_id, :name], unique: true
  end
end

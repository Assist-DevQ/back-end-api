class AddIndexUniqueOnRuns < ActiveRecord::Migration[6.0]
  def change
    add_index :runs, [:scenario_id, :commit_hash, :type], unique: true
  end
end

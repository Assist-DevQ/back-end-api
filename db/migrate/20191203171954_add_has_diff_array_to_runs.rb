class AddHasDiffArrayToRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :has_diff, :string, default: [].to_yaml
  end
end

class AddHasDiffArrayToRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :has_diff, :text
  end
end

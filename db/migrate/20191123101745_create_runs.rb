class CreateRuns < ActiveRecord::Migration[6.0]
  def change
    create_table :runs do |t|
      t.references :scenario, null: false, foreign_key: true
      t.text :images_list
      t.string :commit_hash
      t.integer :type

      t.timestamps
    end
  end
end

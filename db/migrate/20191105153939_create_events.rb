class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.json :data
      t.bigint :time
      t.references :scenario, null: false, foreign_key: true

      t.timestamps
    end
  end
end

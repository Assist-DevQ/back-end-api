class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository_link
      t.string :production_url

      t.timestamps
    end
  end
end

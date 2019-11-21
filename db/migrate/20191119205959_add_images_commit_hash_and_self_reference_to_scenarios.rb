class AddImagesCommitHashAndSelfReferenceToScenarios < ActiveRecord::Migration[6.0]
  def change
    add_column :scenarios, :images, :string, default: [].to_yaml
    add_column :scenarios, :commit_hash, :string
    add_reference :scenarios, :base
  end
end

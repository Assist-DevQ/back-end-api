class AddImagesToScenarios < ActiveRecord::Migration[6.0]
  def change
  	add_column :scenarios, :images, :string, default: [].to_yaml
  end
end

class AddUserAndRepoToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :user_repo, :string
    add_column :projects, :repository_name, :string
  end
end

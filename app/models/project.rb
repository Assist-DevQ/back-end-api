class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }

  before_save :generate_user_and_repo

  has_many :scenarios

  def generate_user_and_repo
    repo_splited = repository_link.split('/')
    self.user = repo_splited[-2]
    self.repository_name = repo_splited[-1]
  end
end

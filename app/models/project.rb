class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }

  before_save :extract_github_user_and_repo

  has_many :scenarios
  has_many :branches

  private

  def extract_github_user_and_repo
    self.user_repo, self.repository_name = repository_link.split('/').last(2)
  end
end

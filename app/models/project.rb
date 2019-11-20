class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }

  before_save :extract_github_user_and_repo

  has_many :scenarios

  private

  def extract_github_user_and_repo
    parsed_repo_url = repository_link.split('/').last(2)
    self.user_repo = parsed_repo_url.first
    self.repository_name = parsed_repo_url.last
  end
end

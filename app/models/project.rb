class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }

  before_save :extract_github_user_and_repo
  after_save :set_base_branch

  has_many :scenarios, dependent: :destroy
  has_many :branches, dependent: :destroy

  private

  def extract_github_user_and_repo
    self.user_repo, self.repository_name = repository_link.split('/').last(2)
  end

  def set_base_branch
    BranchManager.new(self, 'master').call
  end
end

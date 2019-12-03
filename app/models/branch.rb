class Branch < ApplicationRecord
  belongs_to :project

  before_save :short_hash_commit

  validates :name, uniqueness: { scope: :project_id }

  private

  def short_hash_commit
    self.current_hash = current_hash[0..6]
  end
end

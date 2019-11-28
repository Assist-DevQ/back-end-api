class Branch < ApplicationRecord
  belongs_to :project

  validates :name, uniqueness: { scope: :project_id }
end

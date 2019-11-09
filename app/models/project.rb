class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }

  has_many :scenarios
end

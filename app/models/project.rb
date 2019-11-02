class Project < ApplicationRecord
  default_scope -> { where(deleted: false) }
end

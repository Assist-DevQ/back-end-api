class Scenario < ApplicationRecord
  belongs_to :project
  has_many :events
  has_many :runs
end

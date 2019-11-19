class Scenario < ApplicationRecord
  belongs_to :project
  has_many :events

  serialize :images, Array
end

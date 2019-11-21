class Scenario < ApplicationRecord
  belongs_to :project
  has_many :events

  has_many :tests, class_name: 'Scenario', foreign_key: 'base_id'
  belongs_to :base, class_name: 'Scenario', optional: true

  serialize :images, Array
end

class Event < ApplicationRecord
  belongs_to :scenario
  serialize :data
end

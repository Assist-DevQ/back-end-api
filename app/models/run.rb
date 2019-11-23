class Run < ApplicationRecord
  belongs_to :scenario

  serialize :images_list, Array
  enum type: { baseline: 0, test: 1, diff: 2 }
end

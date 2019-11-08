module Common
  module Entities
    class Event < Grape::Entity
      root :events, :event

      expose :id, documentation: { type: Integer }
      expose :data
      expose :time
  end
end
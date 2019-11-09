module Common
  module Entities
    class Event < Grape::Entity
      root :events, :event

      expose :id, documentation: { type: Integer }
      expose :data, documentation: { type: Hash }
      expose :time, documentation: { type: Integer }
    end

    class Scenario < Grape::Entity
      root :scenarios, :scenario

      expose :id, documentation: { type: Integer }
      expose :name
    end
  end
end

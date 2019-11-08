module Admin
  module Entities
    class Scenario < Grape::Entity
      root :scenarios, :scenario

      expose :id, documentation: { type: Integer }
      expose :name
    end

    # class Event < Event
    # end

    class Project < Grape::Entity
      root :projects, :project

      expose :id, documentation: { type: Integer }
      expose :name
      expose :repository_link
      expose :production_url
    end

    class FullProject < Project
    	expose :scenarios, using: Scenario
    end
  end
end

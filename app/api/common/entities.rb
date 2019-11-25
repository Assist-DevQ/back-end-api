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

    class Project < Grape::Entity
      root :projects, :project

      expose :id, documentation: { type: Integer }
      expose :name
      expose :repository_link
      expose :production_url
      expose :user_repo
      expose :repository_name
    end
  end
end

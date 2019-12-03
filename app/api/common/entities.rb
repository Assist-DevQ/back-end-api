module Common
  module Entities
    class Branch < Grape::Entity
      root :branches, :branch

      expose :id, documentation: { type: Integer }
      expose :name
      expose :current_hash
    end

    class Event < Grape::Entity
      root :events, :event

      expose :id, documentation: { type: Integer }
      expose :name
      expose :data, documentation: { type: Hash }
      expose :time, documentation: { type: Integer }
    end

    class Run < Grape::Entity
      root :runs, :run

      expose :commit_hash
      expose :images_list, documentation: { type: Array }
      expose :has_diff, documentation: { type: Array }
      expose :type, documentation: { values: ::Run.types.keys }
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

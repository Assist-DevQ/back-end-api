module Admin
  module Entities
    class Event < Common::Entities::Event
    end

    class Scenario < Common::Entities::Scenario
    end

    class FullScenario < Scenario
      expose :events, using: Event, documentation: { is_array: true }
    end

    class Project < Common::Entities::Project
    end

    class FullProject < Project
      expose :scenarios, using: Scenario, documentation: { is_array: true }
    end
  end
end

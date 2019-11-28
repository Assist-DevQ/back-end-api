module Admin
  module Entities
    class Branch < Common::Entities::Branch
    end

    class Event < Common::Entities::Event
    end

    class Run < Common::Entities::Run
    end

    class Scenario < Common::Entities::Scenario
    end

    class FullScenario < Scenario
      expose :runs, using: Run, documentation: { is_array: true }
      expose :events, using: Event, documentation: { is_array: true }
    end

    class Project < Common::Entities::Project
    end

    class FullProject < Project
      expose :branches, using: Branch, documentation: { is_array: true }
      expose :scenarios, using: Scenario, documentation: { is_array: true }
    end
  end
end

module Admin
  module Entities
    class Project < Grape::Entity
      root :projects, :project

      expose :id, documentation: { type: Integer }
      expose :name
      expose :repository_link
      expose :production_url
    end
  end
end

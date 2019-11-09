module Extension
  class ScenariosApi < Grape::API
    params do
      with(documentation: { in: 'query' }) do
        requires :project_id, type: Integer, allow_blank: false
      end
    end

    resource :scenarios do
      helpers do
        def current_project
          Project.find(params.fetch(:project_id))
        end
      end

      desc 'Get all scenarios' do
        tags %w[scenarios]
        http_codes [
          { code: 200, model: Entities::Scenario, message: 'Scenarios list' }
        ]
      end
      get do
        scenarios = current_project.scenarios
        present scenarios, with: Entities::Scenario
      end
    end
  end
end

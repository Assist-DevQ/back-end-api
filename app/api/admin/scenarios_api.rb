module Admin
  class ScenariosApi < Grape::API
    params do
      with(documentation: { in: 'query' }) do
        requires :project_id, type: Integer, allow_blank: false
      end
    end

    resource :scenarios do
      helpers do
        def current_project
          Project.find_by(id: params.fetch(:project_id))
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

      desc 'Create scenario' do
        tags %w[scenarios]
        http_codes [
          { code: 201, model: Entities::Scenario, message: 'Scenario successfully created' },
          { code: 400, message: 'Parameters are invalid' }
        ]
      end
      params do
        with(documentation: { in: 'body' }) do
          requires :scenario, type: Hash do
            requires :name, type: String, allow_blank: false
          end
        end
      end
      post do
        scenario = current_project.scenarios.create!(params[:scenario])
        present scenario, with: Entities::Scenario
      end

      desc 'Delete scenario' do
        tags %w[scenarios]
        http_codes [
          { code: 204, message: 'No content' },
          { code: 404, message: 'Scenario not found' }
        ]
      end
      delete do
        scenario = Scenario.find(params[:id])
        scenario.destroy
        status :no_content
      end
    end
  end
end

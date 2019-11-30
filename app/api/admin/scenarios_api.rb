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
        # TODO: Call chrome extension to register events for this scenario - any URL?
        # TODO: Register baseline run for master branch
        present scenario, with: Entities::Scenario
      end

      route_param :id do
        desc 'Get scenario' do
          tags %w[scenarios]
          http_codes [
            { code: 200, model: Entities::FullScenario, message: 'Scenario data' },
            { code: 404, message: 'Scenario not found' }
          ]
        end
        get do
          scenario = current_project.scenarios.includes(:runs).find(params[:id])
          present scenario, with: Entities::FullScenario
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
end

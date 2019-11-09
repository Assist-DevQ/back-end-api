module Extension
  class EventsApi < Grape::API
    params do
      with(documentation: { in: 'query' }) do
        requires :scenario_id, type: Integer, allow_blank: false
      end
    end

    resource :events do
      helpers do
        def current_scenario
          Scenario.find(params.fetch(:scenario_id))
        end
      end

      desc 'Create event' do
        tags %w[events]
        http_codes [
          { code: 201, model: Entities::Event, message: 'Event successfully created' },
          { code: 400, message: 'Parameters are invalid' }
        ]
      end
      params do
        with(documentation: { in: 'body' }) do
          requires :event, type: Hash do
            with(allow_blank: false) do
              requires :name, type: String
              requires :data, type: JSON
              requires :time, type: Integer
            end
          end
        end
      end
      post do
        event = current_scenario.events.create!(params[:event])
        present event, with: Entities::Event
      end
    end
  end
end

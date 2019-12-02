module Extension
  class EventsApi < Grape::API
    helpers do
      def current_scenario
        Scenario.find(params.fetch(:scenario_id))
      end
    end

    # https://developers.google.com/gmail/api/guides/batch
    desc 'Batch events creation' do
      tags %w[events]
      http_codes [
        { code: 200, message: 'Events successfully created' },
        { code: 400, message: 'Parameters are invalid' }
      ]
    end
    params do
      with(documentation: { in: 'body' }) do
        requires :scenario_id, type: Integer, allow_blank: false
        requires :events, type: Array do
          with(allow_blank: false) do
            requires :name, type: String
            requires :data, type: JSON
            requires :time, type: Integer
          end
        end
      end
    end
    post 'batch/events' do
      current_scenario.events.destroy_all
      events = params[:events].each { |ev| ev[:scenario_id] = params[:scenario_id] }
      Event.insert_all!(events)
      status :ok
    end

    resource :events do
      desc 'Create event' do
        tags %w[events]
        http_codes [
          { code: 201, model: Entities::Event, message: 'Event successfully created' },
          { code: 400, message: 'Parameters are invalid' }
        ]
      end
      params do
        with(documentation: { in: 'body' }) do
          requires :scenario_id, type: Integer, allow_blank: false
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

module Common
	class EventsApi<Grape::API 
		params do
	    with(documentation: { in: 'query' }) do
	      requires :scenario_id, type: Integer, allow_blank: false
	    end
	  end

		resource  :events do 
			helpers do
        def current_scenario
          Sceanrio.find_by(id: params.fetch(:scenario_id))
        end
      end

			desc 'Get all events' do
				tags %w[events]
        http_codes [
          { code: 200, model: Entities::Event, message: 'Events list' }
        ]
      end
      get do
        events = current_scenario.events
        present events, with: Entities::Event
      end

			desc 'Create event' do
        tags %w[events]
        http_codes [
          { code: 201, model: Entities::events, message: 'Event successfully created' },
          { code: 400, message: 'Parameters are invalid' }
        ]
      end
      params do
        with(documentation: { in: 'body' }) do
          requires :event, type: Hash do
          	requires :name, type: String, allow_blank: false
          	requires :data, type: Hash, allow_blank: false
          	requires :time, type: String, allow_blank: false
          end
        end
      end
      post do
        scenario = current_scenario.events.create!(params[:event])
        present event, with: Entities::Event
      end

			desc 'Delete event' do
        tags %w[events]
        http_codes [
          { code: 204, message: 'No content' },
          { code: 404, message: 'Event not found' }
        ]
      end
      delete do
        event = Event.find(params[:id])
        event.destroy
        status :no_content
      end
		end
	end
end
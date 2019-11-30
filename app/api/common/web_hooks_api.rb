module Common
  class WebHooksApi < Grape::API
    desc 'Handle notification events' do
      http_codes [
        { code: 201, message: 'WebHook is handled' },
        { code: 400, message: 'Bad request' }
      ]
    end
    post do
      event_type = request.headers['X-Github-Event']
      payload = JSON.parse(request.body.string)
      if GithubPayloadProcessor.new(event_type, payload).call == :invalid
        status :bad_request
      else
        status :created
      end
    end
  end
end

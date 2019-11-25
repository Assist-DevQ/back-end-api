module Extension
  class RootApi < Grape::API
    format :json

    rescue_from ActiveRecord::RecordNotFound do
      error!('Not Found', 404)
    end

    http_basic do |username, password|
      ENV['SWAGGER_USERNAME'] == username && ENV['SWAGGER_PASSWORD'] == password
    end

    mount ProjectsApi
    mount ScenariosApi
    mount EventsApi

    add_swagger_documentation(
      format: :json,
      base_path: '/extension/api/v1',
      mount_path: 'docs',
      info: { title: 'DevQ Extension API docs' },
      models: [],
      array_use_braces: true,
      add_root: true
    )
  end
end

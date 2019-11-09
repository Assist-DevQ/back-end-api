module Admin
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

    add_swagger_documentation(
      format: :json,
      base_path: '/admin/api/v1',
      mount_path: 'docs',
      info: { title: 'DevQ Administration API docs' },
      models: [],
      array_use_braces: true,
      add_root: true
    )
  end
end

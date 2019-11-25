module Extension
  class ProjectsApi < Grape::API
    resource :projects do
      desc 'Get all projects' do
        tags %w[projects]
        http_codes [
          { code: 200, model: Entities::Project, message: 'Projects list' }
        ]
      end
      get do
        projects = Project.all
        present projects, with: Entities::Project
      end
    end
  end
end

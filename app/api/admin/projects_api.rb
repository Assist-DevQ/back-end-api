module Admin
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

      desc 'Create project' do
        tags %w[projects]
        http_codes [
          { code: 201, model: Entities::Project, message: 'Project successfully created' },
          { code: 400, message: 'Params are invalid' }
        ]
      end
      params do
        with(documentation: { in: 'body' }) do
          requires :project, type: Hash do
            requires :name, type: String, allow_blank: false
            requires :repository_link, type: String, allow_blank: false
            requires :production_url, type: String, allow_blank: false
          end
        end
      end
      post do
        project = Project.create!(params[:project])
        present project, with: Entities::Project
      end

      route_param :id do
        desc 'Get project' do
          tags %w[projects]
          http_codes [
            { code: 200, model: Entities::Project, message: 'Project data' },
            { code: 404, message: 'Project not found' }
          ]
        end
        get do
          project = Project.find(params[:id])
          present project, with: Entities::Project
        end

        desc 'Update project' do
          tags %w[projects]
          http_codes [
            { code: 200, model: Entities::Project, message: 'Project successfully updated' },
            { code: 400, message: 'Params are invalid' },
            { code: 404, message: 'Project not found' }
          ]
        end
        params do
          with(documentation: { in: 'body' }) do
            requires :project, type: Hash do
              optional :name, type: String, allow_blank: false
              optional :repository_link, type: String, allow_blank: false
              optional :production_url, type: String, allow_blank: false
            end
          end
        end
        put do
          project = Project.find(params[:id])
          project.update!(params[:project])
          present project, with: Entities::Project
        end

        desc 'Delete project' do
          tags %w[projects]
          http_codes [
            { code: 204, message: 'No content' },
            { code: 404, message: 'Project not found' }
          ]
        end
        delete do
          project = Project.find(params[:id])
          project.update!(deleted: true)
          status :no_content
        end
      end
    end
  end
end

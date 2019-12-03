class RunsCreation
  DEVQ_SCREENSHOT_URL = 'http://3fd10c9e.ngrok.io/generate'.freeze

  def initialize(project, base_branch, diff_branch)
    @project = project
    @base_branch = base_branch
    @diff_branch = diff_branch
  end

  def call
    process_response
  end

  private

  attr_reader :project, :base_branch, :diff_branch

  def params
    {
      "projectId": project.id,
      "user": project.user_repo,
      "repo": project.repository_name,
      "baseBranch": base_branch,
      "diffBranch": diff_branch
    }
  end

  def generate_screens
    uri = URI.parse(DEVQ_SCREENSHOT_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false
    request = Net::HTTP::Post.new(
      uri.path,
      'Content-Type' => 'application/json;charset=utf-8'
    )
    request.body = params.to_json
    response_body = http.request(request).body
    JSON.parse(response_body)
  end

  def process_response
    generate_screens['files'].each do |file_with_info|
      base_commit_hash = file_with_info.dig('meta', 'commitId')
      diff_commit_hash = file_with_info.dig('meta', 'diffCommitId')
      scenario_id = file_with_info.dig('meta', 'scenarioId')
      base_images = []
      compare_images = []
      has_diff = []

      file_with_info['files'].each do |file|
        base_images << file['baseFileUrl']
        compare_images << file['diffFileUrl']
        has_diff << file['hasDiff']
      end

      ApplicationRecord.transaction do
        Run.create!(
          scenario_id: scenario_id,
          commit_hash: base_commit_hash,
          type: 'baseline',
          images_list: base_images,
          has_diff: has_diff
        )
        Run.create!(
          scenario_id: scenario_id,
          commit_hash: diff_commit_hash,
          type: 'diff',
          images_list: compare_images,
          has_diff: has_diff
        )
      end
    end
  end
end

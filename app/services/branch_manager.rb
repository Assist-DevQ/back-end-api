class BranchManager
  GITHUB_API_URL = 'https://api.github.com'.freeze

  def initialize(project, branch_name)
    @project = project
    @branch_name = branch_name
  end

  def call
    Branch.find_or_create_by(name: branch_name, project: project) do |branch|
      branch.current_hash = last_commit_hash
    end
  end

  private

  attr_reader :project, :branch_name

  def get_by_uri(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.path)
    response_body = http.request(request).body
    JSON.parse(response_body)
  end

  def last_commit_hash
    url = "#{GITHUB_API_URL}/repos/#{project.user_repo}/#{project.repository_name}/commits/#{branch_name}"
    get_by_uri(url)['sha']
  end
end

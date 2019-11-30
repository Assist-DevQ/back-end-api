class GithubPayloadProcessor
  def initialize(event_type, payload)
    @event_type = event_type
    @payload = payload
  end

  def call
    case event_type
    when 'pull_request'
      process_pull_request
    when 'push'
      process_push
    else
      :invalid
    end
  end

  private

  attr_reader :event_type, :payload

  def project
    repo_url = payload.dig('repository', 'html_url')
    Project.find_by(repository_link: repo_url)
  end

  def branch_name
    if event_type == 'pull_request'
      payload.dig('pull_request', 'head', 'ref')
    elsif event_type == 'push'
      payload['ref'].split('/').last
    end
  end

  def head_current_hash
    if event_type == 'pull_request'
      payload.dig('pull_request', 'head', 'sha')
    elsif event_type == 'push'
      payload.dig('head_commit', 'id')
    end
  end

  def merge_commit_hash
    payload.dig('pull_request', 'merge_commit_sha') if payload['action'] == 'closed'
  end

  def process_pull_request
    case payload['action']
    when 'opened'
      process_opened_pr
    when 'closed'
      process_closed_pr
    else
      :invalid
    end
  end

  def process_push
    branch = Branch.find_or_create_by(name: branch_name, project: project)
    branch.update!(current_hash: head_current_hash)
    # generate new runs
  end

  def process_opened_pr
    Branch.create!(
      name: branch_name,
      project: project,
      current_hash: head_current_hash
    )
    # notify Andrei to create runs
  end

  def process_closed_pr
    # delete branch
    merged_branch = Branch.find_by(name: branch_name, project: project)
    merged_branch.destroy
    # update master branch current_hash
    base_branch = Branch.find_by(name: 'master', project: project)
    base_branch.update!(current_hash: merge_commit_hash)
    # update runs baseline
    # drop runs - test & diff ?
  end
end

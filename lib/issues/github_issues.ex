defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir finn@example.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, response}) do
    { :ok, :jsx.decode(response.body) }
  end

  def handle_response({:error, reason}) do
    { :error, reason }
  end

end

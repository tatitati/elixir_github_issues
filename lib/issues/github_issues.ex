defmodule Issues.GithubIssues do
    @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
    @github_url Application.get_env(:issues, :github_url)
    #example use:
    # Issues.GithubIssues.fetch("elixir-lang", "elixir")

    def fetch(user, project) do
        issues_url(user, project)
            |> HTTPoison.get(@user_agent)
            |> handle_response
    end

    def issues_url(user, project) do
        "#{@github_url}/repos/#{user}/#{project}/issues"
    end

    def handle_response(%{status_code: 200, body: body}),  do: {:ok, body}

    def handle_response(%{status_code: ___, body: body}),  do: {:error, :jsx.decode(body)}
end
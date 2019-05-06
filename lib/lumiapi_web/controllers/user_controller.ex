import Fluminus

defmodule LumiapiWeb.UserController do
  use LumiapiWeb, :controller

  def index(conn, %{"username" => username, "password" => password, "path" => path}) do
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), path)
    json conn, body
  end

  def get_auth(username, password) do
    {:ok, auth} = Fluminus.Authorization.jwt(username, password)
    auth
  end

  def raw_api_call(%Fluminus.Authorization{jwt: jwt}, path) do
    headers = []
    headers =
      headers ++
        [
          {"Authorization", "Bearer #{jwt}"},
          {"Ocp-Apim-Subscription-Key", "6963c200ca9440de8fa1eede730d8f7e"},
          {"Content-Type", "application/json"}
        ]
    uri = "https://luminus.azure-api.net"|> URI.merge(path) |> URI.to_string()
    Fluminus.HTTPClient.request(%Fluminus.HTTPClient{}, 
                                :get, 
                                uri,
                                "",
                                headers)
  end

end

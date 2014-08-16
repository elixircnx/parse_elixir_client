defmodule ParseElixirClient.Request do

  @parse_url "https://api.parse.com"
  @parse_version "/1/"

  @doc """
  A function to create a connection with api.parse.com.
  This connection is then kept open.
  This function is not used at the moment.
  """
  def create_conn(url \\ 'api.parse.com') do
    trans = :hackney_ssl_transport
    opts = []
    {:ok, connpid} = :hackney.connect trans, url, 443, opts
  end

  def make_request(method, path, body, headers, options) do
    #{:ok, _, _, connpid} = :hackney.send_request connpid, {method, path, headers, body}
    url = @parse_url <> @parse_version <> path
    HTTPoison.request method, url, body, headers, options
  end

end

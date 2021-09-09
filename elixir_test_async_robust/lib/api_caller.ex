defmodule ApiCaller do
  @url "http://127.0.0.1:8080/health"

  @options [
    # Connection
    timeout: 100,
    # Receive
    recv_timeout: 2500
  ]

  def get() do
    @url
    |> HTTPoison.get([], @options)
    |> parse_response()
    |> IO.inspect()
  end

  # Returned 200 - OK
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Poison.decode(body)
  end

  # Returned 500 - Server error
  defp parse_response({:ok, %HTTPoison.Response{body: _body, status_code: 500}}) do
    {:error, "Server error"}
  end

  # Connect Timeout case. See https://github.com/edgurgel/httpoison/issues/215#issuecomment-274616923
  defp parse_response({:error, :connect_timeout}) do
    {:error, "Connect Timeout"}
  end

  # Receive Timeout case. See https://github.com/edgurgel/httpoison/issues/215#issuecomment-274616923
  defp parse_response({:error, :timeout}) do
    {:error, "Receive Timeout"}
  end

  defp parse_response(_) do
    {:error, "Unknown"}
  end
end

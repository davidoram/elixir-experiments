defmodule ApiCaller do
  @url "http://127.0.0.1:8080/health"

  @options [
    # Connection
    timeout: 100,
    # Receive
    # If make timeout smaller that server (5s), HTTPoison will return timeout
    recv_timeout: 2_500
  ]

  def get(id) do
    response = @url
      |> HTTPoison.get([], @options)
      |> parse_response()
      |> IO.inspect(label: id)
    response
  end

  # Returned 200 - OK
  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Poison.decode(body)
  end

  # Returned 500 - Server error
  defp parse_response({:ok, %HTTPoison.Response{body: _body, status_code: 500}}) do
    {:error, "Server error"}
  end

  # TODO - Swap this in and the process will crash if an exception occurs
  # # Returned 500 - Raise an exception
  # defp parse_response({:ok, %HTTPoison.Response{body: _body, status_code: 500}}) do
  #  raise "Boom!"
  # end

  # Connect Timeout case. See https://github.com/edgurgel/httpoison/issues/215#issuecomment-274616923
  defp parse_response({:error, %HTTPoison.Error{id: nil, reason: :connect_timeout}}) do
    {:error, "Connect Timeout"}
  end

  # Receive Timeout case. See https://github.com/edgurgel/httpoison/issues/215#issuecomment-274616923
  defp parse_response({:error, %HTTPoison.Error{id: nil, reason: :timeout}}) do
    {:error, "Receive Timeout"}
  end

  defp parse_response(any) do
    IO.puts "Unmatches response: #{IO.inspect(any)}"
    {:error, "Unknown"}
  end
end

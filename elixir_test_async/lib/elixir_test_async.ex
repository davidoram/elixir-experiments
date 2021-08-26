defmodule ElixirTestAsync do
  @moduledoc """
  Documentation for `ElixirTestAsync`.
  """

  def main(_args \\ []) do
    HTTPoison.start

    IO.inspect("Async")
    :timer.tc(fn ->
                call_async()
                :ok
              end) |> IO.inspect()

    IO.inspect("Sync")
    :timer.tc(fn ->
                call_sync()
                :ok
              end) |> IO.inspect()


  end

  def call_async do
    tasks = [
      Task.async(fn -> IO.puts(call_api()) end),
      Task.async(fn -> IO.puts(call_api()) end),
      Task.async(fn -> IO.puts(call_api()) end),
    ]
    Task.await_many(tasks)
  end

  def call_sync do
    Enum.each(0..2, fn(s) -> IO.puts(call_api()) end)
  end

  # Call the slow_server which will pause for a given period
  # See https://github.com/davidoram/slow-server
  def call_api do
    url = "http://127.0.0.1:8080/"
    options = [
                params: [ d: "750ms" ],  # Tell slow_server to pause for this duration
                timeout: 30000,
                recv_timeout: 30000
              ]
    {:ok, response} = HTTPoison.get( url, [], options )
    response.body
  end

end

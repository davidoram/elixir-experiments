defmodule ElixirTestAsync do
  def main(_args \\ []) do

    # Run API calls concurrently
    tasks = [
      Task.async(fn ->  ApiCaller.get(1) end),
      Task.async(fn ->  ApiCaller.get(2) end),
      Task.async(fn ->  ApiCaller.get(3) end),
      Task.async(fn ->  ApiCaller.get(4) end),
      Task.async(fn ->  ApiCaller.get(5) end),
      Task.async(fn ->  ApiCaller.get(6) end),
      Task.async(fn ->  ApiCaller.get(7) end),
      Task.async(fn ->  ApiCaller.get(8) end),
      Task.async(fn ->  ApiCaller.get(9) end),
      Task.async(fn ->  ApiCaller.get(10) end),
    ]

    # Wait for them to complete or timeout
    # TODO - Make the timeout to small and will crash if Tasks not completed within that time
    responses = Task.await_many(tasks, 10_000)
      |> IO.inspect(label: "All finished" )

    # Summarise the calls
    Enum.count(responses)
      |> IO.inspect(label: "Total API calls attempted" )

    Enum.count(responses, &is_ok/1)
      |> IO.inspect(label: "Total returned :ok" )
  end

  defp is_ok(x) do
    case x do
      {:ok, _} -> true
      _default -> false
    end
  end

end

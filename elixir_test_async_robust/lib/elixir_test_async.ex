defmodule ElixirTestAsync do
  def main(_args \\ []) do
    HTTPoison.start

    tasks = List.duplicate(Task.async(fn ->  ApiCaller.get() end), 5)
    Task.await_many(tasks)
    IO.inspect(tasks)
  end

end

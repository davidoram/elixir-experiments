defmodule ElixirTestAsyncTest do
  use ExUnit.Case
  doctest ElixirTestAsync

  test "greets the world" do
    assert ElixirTestAsync.hello() == :world
  end
end

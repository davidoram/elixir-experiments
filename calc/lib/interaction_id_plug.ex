defmodule InteractionIdPlug do
  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  @doc """
  Retrieves the 'x-interaction_id header' for logging
  """
  def call(conn, _opts) do
    interaction =
      conn
      |> get_req_header("x-interaction-id")
      |> get_val()
      |> generate_if_blank()

    Logger.metadata(x_interaction_id: interaction)

    # Set it back into the headers, so downstream plugs
    # get the same value
    conn
    |> put_req_header("x-interaction-id", interaction)
  end

  defp get_val([value | _]), do: value
  defp get_val(_), do: nil

  defp generate_if_blank(nil) do
    "gen=#{System.unique_integer([:monotonic])}"
  end
  defp generate_if_blank(interaction), do: interaction
end

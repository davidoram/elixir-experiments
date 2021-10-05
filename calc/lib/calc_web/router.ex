defmodule CalcWeb.Router do
  use Plug.ErrorHandler
  use CalcWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CalcWeb do
    pipe_through :api

    get "/:op/:num1/:num2", CalcController, :calc
  end

  # See https://www.amberbit.com/blog/2018/7/24/when-web-requests-fail-in-elixir-and-phoenix/
  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    logger
    data = %{
      kind:           "Errors",
      id:             "{uuid}",
      created_at:     "{datetime}",
      interaction_id: "{uuid}"
    }
    response = Phoenix.json_library().encode_to_iodata!(data)
    send_resp(conn, 500, response)
  end
end

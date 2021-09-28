defmodule CalcWeb.Router do
  use CalcWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CalcWeb do
    pipe_through :api

    get "/:op/:num1/:num2", CalcController, :calc
  end
end

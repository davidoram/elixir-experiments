defmodule CalcWeb.CalcController do
    use CalcWeb, :controller
    require Logger

    def calc(conn, %{"num1" => num1, "op" => op, "num2" => num2}) do

      {n1 , ""} = Integer.parse(num1)
      {n2 , ""} = Integer.parse(num2)

      answer = case op do
        "+" -> n1 + n2
        "-" -> n1 - n2
        "div" -> n1 / n2
        "mult" -> n1 * n2
      end

      Logger.info("Calc ok", http_response: Phoenix.json_library().encode!(%{answer: answer}))
      html(conn, "#{n1} #{op} #{n2} = #{answer}")
    end
  end
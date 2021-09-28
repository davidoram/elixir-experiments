defmodule CalcWeb.CalcController do
    use CalcWeb, :controller

    def calc(conn, %{"num1" => num1, "op" => op, "num2" => num2}) do

      {n1 , ""} = Integer.parse(num1)
      {n2 , ""} = Integer.parse(num2)

      answer = case op do
        "+" -> n1 + n2
        "-" -> n1 - n2
        "div" -> n1 / n2
        "mult" -> n1 * n2
      end

      html(conn, """
        <html>
        <h1>Calculator!</h1>
        <p>#{n1} #{op} #{n2} = #{answer}
        </html>
      """)
    end
  end
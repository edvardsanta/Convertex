defmodule ConvertexWeb.ConvertController do
  alias ConvertexWeb.ConverterFactory
  use ConvertexWeb, :controller

  def create(conn, %{"number" => number, "from" => from, "to" => to}) do
    {:ok, factory_result} = ConverterFactory.convert(%{"from" => from, "to" => to}, number)

    conn
    |> put_status(:ok)
    |> json(%{result: factory_result})
  end
end

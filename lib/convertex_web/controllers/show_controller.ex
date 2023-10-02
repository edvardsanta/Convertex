defmodule ConvertexWeb.ShowController do
  use ConvertexWeb, :controller

  def show(conn, %{"messenger" => messenger}) do
    if String.trim(messenger) == "" do
      render(conn, :show, layout: false, messenger: "it is broken")
    end

    render(conn, :show, layout: false, messenger: messenger)
  end
end

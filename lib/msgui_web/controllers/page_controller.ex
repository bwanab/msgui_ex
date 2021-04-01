defmodule MsguiWeb.PageController do
  use MsguiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule OpedWeb.PageController do
  use OpedWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

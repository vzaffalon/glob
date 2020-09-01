defmodule GlobWeb.PageController do
  use GlobWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

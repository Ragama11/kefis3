defmodule Kefis3Web.PageController do
  use Kefis3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

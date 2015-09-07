defmodule SquareSquareBackend.PageController do
  use SquareSquareBackend.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

defmodule SquareSquareBackend.SquareView do
  use SquareSquareBackend.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tiles, :dimension]

  def render("index.json", %{squares: squares}) do
    %{data: render_many(squares, SquareSquareBackend.SquareView, "square.json")}
  end

  def render("show.json", %{square: square}) do
    %{data: render_one(square, SquareSquareBackend.SquareView, "square.json")}
  end

  def render("square.json", %{square: square}) do
    %{id: square.id,
      dimension: square.dimension,
      tiles: square.tiles
    }
  end
end

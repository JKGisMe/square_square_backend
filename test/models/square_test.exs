defmodule SquareSquareBackend.SquareTest do
  use SquareSquareBackend.ModelCase

  alias SquareSquareBackend.Square

  @valid_attrs %{dimension: 42, tiles: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Square.changeset(%Square{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Square.changeset(%Square{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule SquareSquareBackend.SquareControllerTest do
  use SquareSquareBackend.ConnCase

  alias SquareSquareBackend.Square
  @valid_attrs %{dimension: 42, tiles: []}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, square_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    square = Repo.insert! %Square{}
    conn = get conn, square_path(conn, :show, square)
    assert json_response(conn, 200)["data"] == %{id: square.id,
      dimension: square.dimension,
      tiles: square.tiles}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, square_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, square_path(conn, :create), square: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Square, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, square_path(conn, :create), square: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    square = Repo.insert! %Square{}
    conn = put conn, square_path(conn, :update, square), square: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Square, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    square = Repo.insert! %Square{}
    conn = put conn, square_path(conn, :update, square), square: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    square = Repo.insert! %Square{}
    conn = delete conn, square_path(conn, :delete, square)
    assert response(conn, 204)
    refute Repo.get(Square, square.id)
  end
end

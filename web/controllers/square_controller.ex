defmodule SquareSquareBackend.SquareController do
  require Logger
  use SquareSquareBackend.Web, :controller

  alias SquareSquareBackend.Square
  # plug :scrub_params, "square" when action in [:create, :update]

  def index(conn, _params) do
    render conn, model: SquareSquareBackend.Repo.all(SquareSquareBackend.Square)  
  end

  def create(conn, %{"data" => %{"attributes" => params}}) do    
    Logger.debug "----params: #{inspect params}"
    changeset = Square.changeset(%Square{}, params)

    case Repo.insert(changeset) do
      {:ok, square} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", square_path(conn, :show, square))
        |> render("show.json", square: square)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SquareSquareBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end
  # def create(conn, %{"data" => %{"attributes" => params}, "type" => "json-api"}) do
  # # create action now has
  # # a "params" object with all the
  # # attribute date from the client request
  # end

  def show(conn, %{"id" => id}) do
    render conn, model: SquareSquareBackend.Repo.get(SquareSquareBackend.Square, id)
  end

  def update(conn, %{"id" => id, "square" => square_params}) do
    square = Repo.get!(Square, id)
    changeset = Square.changeset(square, square_params)

    case Repo.update(changeset) do
      {:ok, square} ->
        render(conn, "show.json", square: square)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SquareSquareBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    square = Repo.get!(Square, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(square)

    send_resp(conn, :no_content, "")
  end
end

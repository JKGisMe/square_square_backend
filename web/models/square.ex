defmodule SquareSquareBackend.Square do
  use SquareSquareBackend.Web, :model

  schema "squares" do
    field :dimension, :integer
    field :tiles, :string

    timestamps
  end

  @required_fields ~w(dimension tiles)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

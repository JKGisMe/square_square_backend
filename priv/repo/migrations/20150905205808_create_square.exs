defmodule SquareSquareBackend.Repo.Migrations.CreateSquare do
  use Ecto.Migration

  def change do
    create table(:squares) do
      add :dimension, :integer
      add :tiles, :string

      timestamps
    end

  end
end

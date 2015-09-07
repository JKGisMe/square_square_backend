defmodule SquareSquareBackend.Repo.Migrations.ChangeTilesToString do
  use Ecto.Migration

  def change do
    alter table(:squares) do
      modify :tiles, :string
    end
  end
end

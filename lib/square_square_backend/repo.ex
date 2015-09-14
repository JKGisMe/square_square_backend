defmodule SquareSquareBackend.Repo do
  use Ecto.Repo, otp_app: :square_square_backend

  def log(log_entry) do
    :ok = :exometer.update ~w(square_square_backend ecto query_exec_time)a, (log_entry.query_time + log_entry.queue_time || 0) / 1_000
    :ok = :exometer.update ~w(square_square_backend ecto query_queue_time)a, (log_entry.queue_time || 0) / 1_000 # Note: You will have to add this to conf/exometer.exs if you want it
    :ok = :exometer.update ~w(square_square_backend ecto query_count)a, 1

    super log_entry
  end
end

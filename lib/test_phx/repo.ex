defmodule TestPhx.Repo do
  use Ecto.Repo,
    otp_app: :test_phx,
    adapter: Ecto.Adapters.Postgres
end

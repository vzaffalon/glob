defmodule Glob.Repo do
  use Ecto.Repo,
    otp_app: :glob,
    adapter: Ecto.Adapters.Postgres
end

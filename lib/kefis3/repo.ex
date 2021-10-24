defmodule Kefis3.Repo do
  use Ecto.Repo,
    otp_app: :kefis3,
    adapter: Ecto.Adapters.Postgres
end

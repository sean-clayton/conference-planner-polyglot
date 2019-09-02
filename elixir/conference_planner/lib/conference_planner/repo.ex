defmodule ConferencePlanner.Repo do
  use Ecto.Repo,
    otp_app: :conference_planner,
    adapter: Ecto.Adapters.Postgres
end

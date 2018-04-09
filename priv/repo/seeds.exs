# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ProjectusApi.Repo.insert!(%ProjectusApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ProjectusApi.Repo
alias ProjectusApi.Missions.Task

timestamp = NaiveDateTime.utc_now

entries =
  1..100
  |> Enum.map(fn _ ->
      %{
        title: Faker.Lorem.sentence(),
        description: Faker.Lorem.sentence(),
        status: :rand.uniform(3) - 1,
        inserted_at: timestamp,
        updated_at: timestamp
      }
    end)

Repo.insert_all(Task, entries)
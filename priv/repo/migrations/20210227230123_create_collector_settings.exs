defmodule Hedgehog.Repo.Migrations.CreateSubscriberSettings do
  use Ecto.Migration

  def change do
    execute("""
    CREATE TABLE collector_settings (
      id TEXT PRIMARY KEY,
      topic TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT 'off' CHECK (status IN ('on', 'off')),
      inserted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """)

    create(unique_index(:collector_settings, [:topic]))
  end
end

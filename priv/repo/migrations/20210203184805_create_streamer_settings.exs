defmodule Hedgehog.Repo.Migrations.CreateStreamerSettings do
  use Ecto.Migration

  def change do
    execute("""
    CREATE TABLE streamer_settings (
      id TEXT PRIMARY KEY,
      symbol TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT 'off' CHECK (status IN ('on', 'off', 'shutdown')),
      inserted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """)

    create(unique_index(:streamer_settings, [:symbol]))
  end
end

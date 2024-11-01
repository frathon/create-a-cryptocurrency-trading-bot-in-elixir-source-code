defmodule Hedgehog.Repo.Migrations.CreateNaiveStrategySettings do
  use Ecto.Migration

  def change do
    execute("""
    CREATE TABLE naive_strategy_settings (
      id TEXT PRIMARY KEY,
      symbol TEXT NOT NULL,
      chunks INTEGER NOT NULL,
      budget DECIMAL NOT NULL,
      buy_down_interval DECIMAL NOT NULL,
      profit_interval DECIMAL NOT NULL,
      rebuy_interval DECIMAL NOT NULL,
      status TEXT NOT NULL DEFAULT 'off' CHECK (status IN ('on', 'off', 'shutdown')),
      inserted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """)
  
    create(unique_index(:naive_strategy_settings, [:symbol]))
  end
end

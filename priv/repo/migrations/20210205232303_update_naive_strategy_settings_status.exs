defmodule Hedgehog.Repo.Migrations.UpdateNaiveStrategySettingsStatus do
  use Ecto.Migration

  @disable_ddl_transaction true

  def change do
    Ecto.Migration.execute("ALTER TYPE naive_trading_status ADD VALUE IF NOT EXISTS 'shutdown'")
  end
end

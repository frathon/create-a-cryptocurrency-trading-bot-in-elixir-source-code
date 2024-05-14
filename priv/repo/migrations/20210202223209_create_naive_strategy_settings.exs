defmodule Hedgehog.Repo.Migrations.CreateNaiveStrategySettings do
  use Ecto.Migration

  alias Hedgehog.Strategy.Naive.SettingsStatusEnum

  def change do
    SettingsStatusEnum.create_type()

    create table(:naive_strategy_settings, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:symbol, :text, null: false)
      add(:chunks, :integer, null: false)
      add(:budget, :decimal, null: false)
      add(:buy_down_interval, :decimal, null: false)
      add(:profit_interval, :decimal, null: false)
      add(:rebuy_interval, :decimal, null: false)
      add(:status, SettingsStatusEnum.type(), default: "off", null: false)

      timestamps()
    end

    create(unique_index(:naive_strategy_settings, [:symbol]))
  end
end

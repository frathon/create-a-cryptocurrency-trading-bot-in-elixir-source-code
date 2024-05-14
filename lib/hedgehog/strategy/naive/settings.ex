defmodule Hedgehog.Strategy.Naive.Settings do
  use Ecto.Schema

  alias Hedgehog.Strategy.Naive.SettingsStatusEnum

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "naive_strategy_settings" do
    field(:symbol, :string)
    field(:chunks, :integer)
    field(:budget, :decimal)
    field(:buy_down_interval, :decimal)
    field(:profit_interval, :decimal)
    field(:rebuy_interval, :decimal)
    field(:status, SettingsStatusEnum)

    timestamps()
  end
end

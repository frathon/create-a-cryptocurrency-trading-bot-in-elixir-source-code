defmodule Hedgehog.Data.Collector.Settings do
  use Ecto.Schema

  alias Hedgehog.Data.Collector.SettingsStatusEnum

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "collector_settings" do
    field(:topic, :string)
    field(:status, SettingsStatusEnum)

    timestamps()
  end
end

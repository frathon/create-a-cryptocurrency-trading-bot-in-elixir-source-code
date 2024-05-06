defmodule Hedgehog.Streaming.Settings do
  use Ecto.Schema

  alias Hedgehog.Streaming.SettingsStatusEnum

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "streaming_settings" do
    field(:symbol, :string)
    field(:status, SettingsStatusEnum)

    timestamps()
  end
end

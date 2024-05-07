defmodule Hedgehog.Streamer.Settings do
  use Ecto.Schema

  alias Hedgehog.Streamer.SettingsStatusEnum

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "streamer_settings" do
    field(:symbol, :string)
    field(:status, SettingsStatusEnum)

    timestamps()
  end
end

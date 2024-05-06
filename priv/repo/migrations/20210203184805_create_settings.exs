defmodule Hedgehog.Repo.Migrations.CreateStreamingSettings do
  use Ecto.Migration

  alias Hedgehog.Streaming.SettingsStatusEnum

  def change do
    SettingsStatusEnum.create_type()

    create table(:streaming_settings, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:symbol, :text, null: false)
      add(:status, SettingsStatusEnum.type(), default: "off", null: false)

      timestamps()
    end

    create(unique_index(:streaming_settings, [:symbol]))
  end
end

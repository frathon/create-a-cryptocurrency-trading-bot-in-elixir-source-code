defmodule Hedgehog.Repo.Migrations.CreateStreamerSettings do
  use Ecto.Migration

  alias Hedgehog.Streamer.SettingsStatusEnum

  def change do
    SettingsStatusEnum.create_type()

    create table(:streamer_settings, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:symbol, :text, null: false)
      add(:status, SettingsStatusEnum.type(), default: "off", null: false)

      timestamps()
    end

    create(unique_index(:streamer_settings, [:symbol]))
  end
end

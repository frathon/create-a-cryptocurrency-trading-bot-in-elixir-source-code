defmodule Hedgehog.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    execute("""
    CREATE TABLE orders (
      order_id BIGINT PRIMARY KEY,
      client_order_id TEXT,
      symbol TEXT,
      price TEXT,
      original_quantity TEXT,
      executed_quantity TEXT,
      cummulative_quote_quantity TEXT,
      status TEXT,
      time_in_force TEXT,
      type TEXT,
      side TEXT,
      stop_price TEXT,
      iceberg_quantity TEXT,
      time BIGINT,
      update_time BIGINT,
      inserted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """)
  end
end

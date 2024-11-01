defmodule Hedgehog.Repo.Migrations.CreateTradeEvents do
  use Ecto.Migration

  def change do
    execute("""
    CREATE TABLE trade_events (
      id TEXT PRIMARY KEY,
      event_type TEXT,
      event_time BIGINT,
      symbol TEXT,
      trade_id INTEGER,
      price TEXT,
      quantity TEXT,
      buyer_order_id BIGINT,
      seller_order_id BIGINT,
      trade_time BIGINT,
      buyer_market_maker INTEGER DEFAULT 0,
      inserted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """)
  end
end

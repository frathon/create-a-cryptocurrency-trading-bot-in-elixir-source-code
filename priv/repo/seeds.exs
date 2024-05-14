require Logger

alias Hedgehog.Repo
alias Hedgehog.Streamer.Settings, as: StreamerSettings
alias Hedgehog.Strategy.Naive.Settings, as: NaiveStrategySettings

binance_client = Application.compile_env(:hedgehog, :binance_client)

Logger.info("Fetching exchange info from Binance to create streaming settings")

{:ok, %{symbols: symbols}} = binance_client.get_exchange_info()

timestamp =
  NaiveDateTime.utc_now()
  |> NaiveDateTime.truncate(:second)

base_settings = %{
  symbol: "",
  status: "off",
  inserted_at: timestamp,
  updated_at: timestamp
}

Logger.info("Inserting default streamer settings for symbols")

maps =
  symbols
  |> Enum.map(&%{base_settings | symbol: &1["symbol"]})

{count, nil} = Repo.insert_all(StreamerSettings, maps, on_conflict: :nothing)

Logger.info("Inserted streamer settings for #{count} symbols")

%{
  chunks: chunks,
  budget: budget,
  buy_down_interval: buy_down_interval,
  profit_interval: profit_interval,
  rebuy_interval: rebuy_interval
} = Application.compile_env(:hedgehog, [:strategy, :naive, :defaults])

base_settings = %{
  symbol: "",
  chunks: chunks,
  budget: Decimal.new(budget),
  buy_down_interval: Decimal.new(buy_down_interval),
  profit_interval: Decimal.new(profit_interval),
  rebuy_interval: Decimal.new(rebuy_interval),
  status: "off",
  inserted_at: timestamp,
  updated_at: timestamp
}

Logger.info("Inserting default naive strategy settings for symbols")

maps =
  symbols
  |> Enum.map(&%{base_settings | symbol: &1["symbol"]})

{count, nil} = Repo.insert_all(NaiveStrategySettings, maps, on_conflict: :nothing)

Logger.info("Inserted naive strategy settings for #{count} symbols")

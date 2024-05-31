defmodule Hedgehog.Data.Aggregator.Ohlc.Worker do
  use GenServer

  require Logger

  alias Hedgehog.Exchange.TradeEvent
  alias Hedgehog.Data.Aggregator.Ohlc

  def start_link(symbol) do
    GenServer.start_link(__MODULE__, symbol)
  end

  def init(symbol) do
    symbol = String.upcase(symbol)

    Logger.info("Initializing a new OHLC worker for #{symbol}")

    Phoenix.PubSub.subscribe(
      Hedgehog.PubSub,
      "TRADE_EVENTS:#{symbol}"
    )

    {:ok, symbol}
  end

  def handle_info(%TradeEvent{} = trade_event, ohlc) do
    {:noreply, Ohlc.process(ohlc, trade_event)}
  end
end

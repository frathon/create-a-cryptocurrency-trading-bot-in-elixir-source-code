defmodule Hedgehog.Data.Collector.Worker do
  use GenServer

  alias Hedgehog.Exchange.Order
  alias Hedgehog.Exchange.TradeEvent
  alias Hedgehog.Repo

  require Logger

  defmodule State do
    @enforce_keys [:topic]
    defstruct [:topic]
  end

  def start_link(topic) do
    GenServer.start_link(
      __MODULE__,
      topic,
      name: via_tuple(topic)
    )
  end

  def init(topic) do
    Logger.info("Collector worker is subscribing to #{topic}")

    Phoenix.PubSub.subscribe(
      Hedgehog.PubSub,
      topic
    )

    {:ok,
     %State{
       topic: topic
     }}
  end

  def handle_info(%TradeEvent{} = trade_event, state) do
    opts =
      trade_event
      |> Map.from_struct()

    struct!(TradeEvent, opts)
    |> Repo.insert()

    {:noreply, state}
  end

  def handle_info(%Binance.Order{} = order, state) do
    data =
      order
      |> Map.from_struct()

    struct(Order, data)
    |> Map.merge(%{
      original_quantity: order.orig_qty,
      executed_quantity: order.executed_qty,
      cummulative_quote_quantity: order.cummulative_quote_qty,
      iceberg_quantity: order.iceberg_qty
    })
    |> Repo.insert(
      on_conflict: :replace_all,
      conflict_target: :order_id
    )

    {:noreply, state}
  end

  defp via_tuple(topic) do
    {:via, Registry, {:collector_workers, topic}}
  end
end

defmodule Hedgehog.Data.Aggregator do
  @moduledoc """
  Documentation for `Hedgehog.Data.Aggregator`.
  """

  def aggregate_ohlcs(symbol) do
    DynamicSupervisor.start_child(
      Hedgehog.Data.Aggregator.DynamicWorkerSupervisor,
      {Hedgehog.Data.Aggregator.Ohlc.Worker, symbol}
    )
  end
end

defmodule Hedgehog.Streaming.Binance do
  @moduledoc """
  Documentation for `Streamer`.
  """
  alias Hedgehog.Streaming.Binance.DynamicStreamerSupervisor

  def start_streaming(symbol) do
    symbol
    |> String.upcase()
    |> DynamicStreamerSupervisor.start_worker()
  end

  def stop_streaming(symbol) do
    symbol
    |> String.upcase()
    |> DynamicStreamerSupervisor.stop_worker()
  end
end

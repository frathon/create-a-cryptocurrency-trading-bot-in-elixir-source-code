defmodule Core.Exchange do
  defmodule SymbolInfo do
    @type t :: %__MODULE__{
            symbol: String.t(),
            tick_size: number(),
            step_size: number()
          }

    defstruct [:symbol, :tick_size, :step_size]
  end

  defmodule Order do
    @type t :: %__MODULE__{
            id: any(),
            price: number(),
            quantity: number(),
            side: :buy | :sell,
            status: :new | :filled,
            timestamp: non_neg_integer()
          }

    defstruct [:id, :price, :quantity, :side, :status, :timestamp]
  end

  @callback fetch_symbols() ::
              {:ok, [String.t()]}
              | {:error, any()}
  @callback fetch_symbol_filters(symbol :: String.t()) ::
              {:ok, Core.Exchange.SymbolInfo.t()}
              | {:error, any()}
  @callback get_order(
              symbol :: String.t(),
              timestamp :: non_neg_integer(),
              order_id :: non_neg_integer()
            ) ::
              {:ok, Core.Exchange.Order.t()}
              | {:error, any()}
  @callback order_limit_buy(symbol :: String.t(), quantity :: number(), price :: number()) ::
              {:ok, Core.Exchange.Order.t()}
              | {:error, any()}
  @callback order_limit_sell(symbol :: String.t(), quantity :: number(), price :: number()) ::
              {:ok, Core.Exchange.Order.t()}
              | {:error, any()}
end

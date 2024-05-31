defmodule Hedgehog.Data.Collector.CollectorSupervisor do
  use Supervisor

  alias Hedgehog.Data.Collector.DynamicWorkerSupervisor

  @registry :collector_workers

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      {Registry, [keys: :unique, name: @registry]},
      {DynamicWorkerSupervisor, []},
      {Task,
       fn ->
         DynamicWorkerSupervisor.autostart_workers()
       end}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end

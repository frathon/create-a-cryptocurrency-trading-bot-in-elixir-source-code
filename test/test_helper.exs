ExUnit.start(capture_log: true)

Application.ensure_all_started(:mimic)

Mimic.copy(Hedgehog.Exchange.BinanceMock)
Mimic.copy(Phoenix.PubSub)

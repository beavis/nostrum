_ = """
  This module exists primarily for documentation/testing purposes
"""

defmodule Dummy do
  @moduledoc false

  def start_link do
    # List comprehension creates a consumer per cpu core
    children = [DummyConsumer]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule DummyConsumer do
  @moduledoc false
  use Nostrum.Consumer

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {message}, _}) do
    Logger.debug(fn -> "Message received: #{inspect(message.content)}" end)
  end

  def handle_event({event_name, _, _}) do
    Logger.debug(fn -> "User would handle #{event_name} here" end)
  end
end

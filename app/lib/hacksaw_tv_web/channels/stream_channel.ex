defmodule HacksawTvWeb.StreamChannel do
  use HacksawTvWeb, :channel
  alias HacksawTvWeb.Presence

  @impl true
  def join(_channel, payload, socket) do
      rp = assign(socket, :id, System.system_time(:second))
      send(self(), :after_join)
      {:ok, rp}
  end


  @spec handle_info(:after_join, Phoenix.Socket.t()) :: {:noreply, Phoenix.Socket.t()}
  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.id, %{
      online_at: inspect(System.system_time(:second))
    })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (stream:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

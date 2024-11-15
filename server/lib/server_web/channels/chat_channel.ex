defmodule ServerWeb.ChatChannel do
  use ServerWeb, :channel

  @impl true
  def join("chat:lobby", payload, socket) do
    # if authorized?(payload) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, "you made it"}, socket}
    broadcast!(socket, "ping", %{body: "you did it!"})
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast!(socket, "shout", payload)
    broadcast!(socket, "shout", %{body: "broadcasting from ping"})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

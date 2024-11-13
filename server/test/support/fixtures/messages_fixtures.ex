defmodule Server.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body"
      })
      |> Server.Messages.create_message()

    message
  end
end

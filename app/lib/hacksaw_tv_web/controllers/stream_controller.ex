defmodule HacksawTvWeb.StreamController do
  use HacksawTvWeb, :controller

  def show(conn, %{"channel" => channel_id}) do

    case HacksawTv.Storage.Streams.find(channel_id) do
      [{^channel_id, channel}] ->
        conn
          |> assign(:channel, channel)
          |> render(:show)
      [] ->
        # TODO: Throw a not_found error
        conn
          |> put_flash(:error, "No such channel: #{channel_id}")
          |> redirect(to: ~p"/")
    end
  end
end

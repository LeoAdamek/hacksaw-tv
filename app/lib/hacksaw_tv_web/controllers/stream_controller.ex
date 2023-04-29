defmodule HacksawTvWeb.StreamController do
  use HacksawTvWeb, :controller

  def show(conn, %{"channel" => channel}) do
    conn
      |> assign(:channel, channel)
      |> render(:show)
  end
end

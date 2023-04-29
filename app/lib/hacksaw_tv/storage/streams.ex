defmodule HacksawTv.Storage.Streams do
  use GenServer
  require Logger

  @table :streams

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :ets.new(@table, [:set, :named_table, :public, read_concurrency: true])

    {:ok, %{}}
  end

  def find(id) do
    :ets.lookup(@table, id)
  end

  @spec create(String.t(), %{name: String.t(), password: String.t() | term()}) :: reference()
  def create(id, %{name: name, password: password}) do
    :ets.insert(@table, {id, %{name: name, password: password}})
  end

end

defmodule HacksawTv.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :hacksaw_tv

  def migrate do
    load_app()
  end

  @spec rollback(any, any) :: :ok | {:error, any}
  def rollback() do
    load_app()
  end

  defp load_app do
    Application.load(@app)
  end
end

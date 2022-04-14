defmodule SurfaceErrorWeb.Plug.BodyReader do
  @moduledoc """
  Custom Body Reader to store the raw body for signature header verification
  in webhooks.
  Based on https://dashbit.co/blog/how-we-verify-webhooks
  """
  def cache_raw_body(conn, opts) do
    with {:ok, body, conn} <- Plug.Conn.read_body(conn, opts) do
      conn = update_in(conn.assigns[:raw_body], &[body | &1 || []])

      {:ok, body, conn}
    end
  end
end

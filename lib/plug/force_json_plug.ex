defmodule SurfaceErrorWeb.Plug.ForceJSON do
  @moduledoc """
  Force content-type header of the request to "application/json" regardless of
  what the client set.

  Created because Amazon SNS sends a JSON body in its webhook requests but a
  a "text/plain" content-type header, and we want to force the request to be
  treated as JSON.
  """
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> put_req_header("content-type", "application/json")
  end
end

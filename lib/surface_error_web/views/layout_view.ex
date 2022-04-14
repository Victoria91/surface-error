defmodule SurfaceErrorWeb.LayoutView do
  use SurfaceErrorWeb, :view

  def is_admin(%{assigns: %{current_user: %{admin: true}}}), do: true
  def is_admin(%{assigns: %{current_user: %{admin: false}}}), do: false
  def is_admin(_), do: false

  def flash_message_class(conn) do
    cond do
      get_flash(conn, :error) -> "alert-danger"
      get_flash(conn, :info) -> "alert-success"
      true -> ""
    end
  end
end

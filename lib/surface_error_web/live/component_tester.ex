defmodule SurfaceErrorWeb.Surface.ComponentTester do
  @moduledoc """
  Dummy LiveView for use in testing Surface Components
  """
  use Surface.LiveView,
    layout: {SurfaceErrorWeb.LayoutView, "blank.html"}

  import Phoenix.LiveViewTest, only: [live_isolated: 3]

  @endpoint SurfaceErrorWeb.Endpoint

  def render(assigns) do
    ~F"""
    {live_component(@component, @props)}
    """
  end

  def mount(_params, session, socket) do
    default_props =
      session["component"].__props__()
      |> Map.new(&{&1.name, &1.opts[:default]})

    props = Map.merge(default_props, session["props"])

    socket =
      socket
      |> assign(:component, session["component"])
      |> assign(:props, props)

    {:ok, socket}
  end

  def live_surface_component(conn, component, props) do
    live_isolated(
      conn,
      __MODULE__,
      session: %{
        "component" => component,
        "props" => props
      }
    )
  end

  def handle_info(_, socket), do: {:noreply, socket}
end

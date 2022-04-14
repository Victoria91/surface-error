defmodule SurfaceErrorWeb.Surface.FormComponentTest do
  use SurfaceErrorWeb.ConnCase, async: true
  use Surface.LiveViewTest
  alias SurfaceErrorWeb.FormComponent

  import SurfaceErrorWeb.Surface.ComponentTester, only: [live_surface_component: 3]

  describe "Files component" do
    test "clears entries if popup is closed", %{
      conn: conn
    } do
      {:ok, view, _html} = live_surface_component(conn, FormComponent, %{id: "id"})

      file =
        file_input(view, "form", :file, [
          %{
            last_modified: 1_594_171_879_000,
            name: "myfile.jpeg",
            content: "some-content",
            size: 1_396_009,
            type: "image/jpeg"
          }
        ])

      render_upload(file, "myfile.jpeg")
    end
  end
end

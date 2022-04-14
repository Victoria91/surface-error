defmodule SurfaceErrorWeb.FormComponent do
  use Surface.LiveComponent

  import SurfaceErrorWeb.Gettext

  alias SurfaceErrorWeb.Surface.Inputs.Dropzone
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, SearchInput}

  data global_upload_errors, :list, default: []
  data uploads, :any

  def mount(socket) do
    socket = allow_upload(socket, :file, accept: :any, max_entries: 1)

    {:ok, socket}
  end

  def render(assigns) do
    ~F"""
    <div :hook="FormSubmitter" id="form-upload">
      <Form submit="save" change="validate" for={:upload}>
        <Field name={:email}>
          <SearchInput opts={
            class: "input input-search",
            placeholder: gettext("Search by email..."),
            autocomplete: "off",
            phx_debounce: 500
          } />
        </Field>
        <Dropzone upload={@uploads.file} />
        <button class="button button-full button-font-semibold button-lg button-shadow-lg button-solid-blue-400">Upload</button>
      </Form>
    </div>
    """
  end

  def handle_event("upload", _, socket) do
    IO.inspect("UPLOAD==")
    {:noreply, push_event(socket, "save", %{})}
  end

  def handle_event("save", _params, socket) do
    IO.inspect("save")
    {:noreply, socket}
  end

  def handle_event("validate", _payload, socket) do
    IO.inspect("validate")
    {:noreply, socket}
  end
end

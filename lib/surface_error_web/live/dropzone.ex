defmodule SurfaceErrorWeb.Surface.Inputs.Dropzone do
  @moduledoc """
  A Dropzone for uploading files
  """
  use Surface.Component
  alias Surface.Components.LiveFileInput

  prop upload, :struct

  def render(assigns) do
    ~F"""
    <div id="dropzone" class="file-upload-dropzone" phx-drop-target={@upload.ref}>
      <LiveFileInput class="file-upload-dropzone-input" upload={@upload} />
      <span>Drag files here or <mark class="file-upload-dropzone-mark">click here</mark> to choose files</span>
    </div>
    """
  end
end

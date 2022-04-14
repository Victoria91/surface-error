defmodule Mix.Tasks.Test.WithCoverage do
  @moduledoc """
  Runs tests with coverage based on env choose different tooling
  """
  use Mix.Task

  @shortdoc "Proxies to different tools based on present of CI flag"
  @impl Mix.Task
  def run(args) do
    if System.get_env("CI"),
      do: Mix.Task.run("coveralls.json", args),
      else: Mix.Task.run("coveralls.lcov", args)
  end
end

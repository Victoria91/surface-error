defmodule SurfaceError.MixProject do
  use Mix.Project

  def project do
    [
      app: :surface_error,
      version: "0.1.0",
      elixir: "~> 1.13.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      elixirc_options: [warnings_as_errors: false],
      compilers: [:gettext] ++ Mix.compilers() ++ [:surface],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.lcov": :test,
        "test.with_coverage": :test
      ],
      xref: [exclude: [Poison, IEx.Pry]],
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore_warnings.exs",
        plt_add_apps: [:ex_unit, :mix],
        # Default plt core path is $MIX_HOME, but let's store it here.
        # Environment versioning is not required in this case since it
        # only stores the erlang and elixir plts (no deps)
        # When runnning dialyzer, it will seek the following files:
        # - dialyxir_erlang-[OTP Version].plt
        # - dialyxir_erlang-[OTP Version]_elixir-[Elixir Version].plt
        # So updating the OTP or elixir versions should create new core plts
        # This also avoids having to rebuild everything when deleting the
        # env specific build like in the `dev` or `test` folders
        plt_core_path: "_build/"

        # `plt_file` is deprecated. dialyxir by default now uses the files:
        # - _build/[env]/dialyxir_erlang-[OTP Version]_elixir-[Elixir Version]_deps-dev.plt
        # - _build/[env]/dialyxir_erlang-[OTP Version]_elixir-[Elixir Version]_deps-dev.plt.hash
        # plt_file: {:no_warn, "_build/#{Mix.env()}/dialyzer.plt"}
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SurfaceError.Application, []},
      extra_applications: [:logger, :runtime_tools, :crypto]
    ]
  end

  def catalogues do
    [
      # Local catalogue
      "priv/catalogue",
      # Dependencies catalogues
      "deps/surface/priv/catalogue"
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:dev), do: ["lib"] ++ catalogues()
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:int_test), do: ["lib", "test/support"] ++ catalogues()
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.11"},
      {:phoenix, "~> 1.6.6", override: true},
      {:phoenix_live_reload, "~> 1.3"},
      {:phoenix_live_view, "~> 0.17.6"},
      {:plug_cowboy, "~> 2.5.2"},
      {:surface, "0.7.0", override: true},
      {:tailwind, "~> 0.1.5", runtime: Mix.env() == :dev},
      {:floki, ">= 0.30.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "phx.digest"
      ]
    ]
  end
end

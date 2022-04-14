[
  import_deps: [:phoenix, :phoenix_live_view, :surface],
  inputs: [
    ".dialyzer_ignore.exs",
    ".formatter.exs",
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "priv/repo/seeds/*.exs",
    "priv/catalogue/**/*.{ex,exs,sface}",
    "{config,lib,test}/**/*.{ex,exs,sface}"
  ],
  surface_inputs: [
    "priv/catalogue/**/*.{ex,exs,sface}",
    "{config,lib,test}/**/*.{ex,exs,sface}"
  ],
  subdirectories: ["priv/*/migrations"],
  locals_without_parens: [plug: 1, plug: 2]
]

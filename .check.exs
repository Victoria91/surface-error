[
  ## don't run tools concurrently
  # parallel: false,

  ## don't print info about skipped tools
  # skipped: false,

  ## always run tools in fix mode (put it in ~/.check.exs locally, not in project config)
  # fix: true,

  ## don't retry automatically even if last run resulted in failures
  # retry: false,

  ## list of tools (see `mix check` docs for a list of default curated tools)
  tools: [
    ## curated tools may be disabled (e.g. the check for compilation warnings)
    # {:compiler, false},

    ## ...or have command & args adjusted (e.g. enable skip comments for sobelow)
    # {:sobelow, "mix sobelow --exit --skip"},

    ## ...or reordered (e.g. to see output from dialyzer before others)
    # {:dialyzer, order: -1},
    {:credo, "mix credo --strict", detect: [{:package, :credo}]},
    {:ex_unit, command: "mix test.with_coverage", retry: "mix test.with_coverage --failed"},
    {:surface_format, "mix surface.format --check-formatted",
     fix: "mix surface.format", order: 3},
    {:check_translation, "mix gettext.extract --check-unextracted",
     fix: "mix gettext.extract --merge"},
    {:prettier, order: 3, command: "npx prettier -c .", fix: "npx prettier -w ."},
    {:sobelow, "mix sobelow --exit --skip"}
  ]
]

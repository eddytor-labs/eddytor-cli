# Eddytor CLI

  The official command-line interface for [Eddytor](https://eddytor.com) — query, manage, and explore Delta Lake tables from your terminal.

  ## Installation

  ### macOS (Homebrew)

  ```bash
  brew install eddytor-labs/tap/eddytor

  Linux (shell script)

  curl -fsSL https://raw.githubusercontent.com/eddytor-labs/eddytor-cli/main/install.sh | sh

  Windows (Scoop)

  scoop bucket add eddytor https://github.com/eddytor-labs/homebrew-tap
  scoop install eddytor

  Manual

  Download the archive for your platform from https://github.com/eddytor-labs/eddytor-cli/releases and add the binary to your PATH.

  Supported platforms

  ┌──────────┬─────────────────────────┐
  │ Platform │      Architecture       │
  ├──────────┼─────────────────────────┤
  │ macOS    │ Apple Silicon (aarch64) │
  ├──────────┼─────────────────────────┤
  │ Linux    │ x86_64, aarch64         │
  ├──────────┼─────────────────────────┤
  │ Windows  │ x86_64                  │
  └──────────┴─────────────────────────┘

  Getting started

  # Configure your Eddytor instance
  eddytor config set-url https://your-instance.eddytor.com
  eddytor config set-token <your-api-key>

  # List tables
  eddytor tables

  # Query data
  eddytor query "SELECT * FROM my_table LIMIT 10"

  # Describe a table
  eddytor tables describe eddytor.cfg_abc123.my_table

  Documentation

  See the https://eddytor.com/docs for full CLI reference.

  License

  Proprietary — All rights reserved.

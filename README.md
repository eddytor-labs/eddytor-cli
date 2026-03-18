# Eddytor CLI

Query, manage, and explore Delta Lake tables from the terminal.

## Installation

### macOS (Homebrew)

```bash
brew install eddytor-labs/tap/eddytor
```

### macOS / Linux (shell script)

```bash
curl -fsSL https://raw.githubusercontent.com/eddytor-labs/eddytor-cli/main/install.sh | sh
```

### Windows (Scoop)

```powershell
scoop bucket add eddytor https://github.com/eddytor-labs/eddytor-cli
scoop install eddytor
```

### Manual download

Download the latest release for your platform from [Releases](https://github.com/eddytor-labs/eddytor-cli/releases) and add the binary to your PATH.

## Getting started

```bash
# Log in via browser (OAuth magic link)
eddytor login

# Or use an API key directly
eddytor config set-key edd_live_<40_hex_chars>

# List discovered tables
eddytor tables

# Query with SQL
eddytor query "SELECT * FROM eddytor.cfg_abc.my_table LIMIT 10"

# Get help
eddytor --help
```

## Updating

```bash
# Homebrew
brew upgrade eddytor

# Scoop
scoop update eddytor

# Shell script (re-run the installer)
curl -fsSL https://raw.githubusercontent.com/eddytor-labs/eddytor-cli/main/install.sh | sh
```

## License

Proprietary. See [eddytor.com](https://eddytor.com) for details.

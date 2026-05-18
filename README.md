# Twilio Jobs Pp Cli CLI

API for accessing Twilio job postings

Printed by [@danielecr](https://github.com/danielecr) (Daniele Cruciani).

## Install

The recommended path installs both the `twilio-jobs-pp-cli-pp-cli` binary and the `pp-twilio-jobs-pp-cli` agent skill (Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, and other agents supported by the upstream [`skills`](https://github.com/vercel-labs/skills) CLI) in one shot:

```bash
npx -y @mvanhorn/printing-press install twilio-jobs-pp-cli
```

For CLI only (no skill):

```bash
npx -y @mvanhorn/printing-press install twilio-jobs-pp-cli --cli-only
```

For skill only — installs the skill into the same agents as the default command above, but skips the CLI binary (use this to update or reinstall just the skill):

```bash
npx -y @mvanhorn/printing-press install twilio-jobs-pp-cli --skill-only
```

To constrain the skill install to one or more specific agents (repeatable — agent names match the [`skills`](https://github.com/vercel-labs/skills) CLI):

```bash
npx -y @mvanhorn/printing-press install twilio-jobs-pp-cli --agent claude-code
npx -y @mvanhorn/printing-press install twilio-jobs-pp-cli --agent claude-code --agent codex
```

### Without Node

The generated install path is category-agnostic until this CLI is published. If `npx` is not available before publish, install Node or use the category-specific Go fallback from the public-library entry after publish.

### Pre-built binary

Download a pre-built binary for your platform from the [latest release](https://github.com/mvanhorn/printing-press-library/releases/tag/twilio-jobs-pp-cli-current). On macOS, clear the Gatekeeper quarantine: `xattr -d com.apple.quarantine <binary>`. On Unix, mark it executable: `chmod +x <binary>`.

<!-- pp-hermes-install-anchor -->
## Install for Hermes

From the Hermes CLI:

```bash
hermes skills install mvanhorn/printing-press-library/cli-skills/pp-twilio-jobs-pp-cli --force
```

Inside a Hermes chat session:

```bash
/skills install mvanhorn/printing-press-library/cli-skills/pp-twilio-jobs-pp-cli --force
```

## Install for OpenClaw

Tell your OpenClaw agent (copy this):

```
Install the pp-twilio-jobs-pp-cli skill from https://github.com/mvanhorn/printing-press-library/tree/main/cli-skills/pp-twilio-jobs-pp-cli. The skill defines how its required CLI can be installed.
```

## Use with Claude Desktop

This CLI ships an [MCPB](https://github.com/modelcontextprotocol/mcpb) bundle — Claude Desktop's standard format for one-click MCP extension installs (no JSON config required).

To install:

1. Download the `.mcpb` for your platform from the [latest release](https://github.com/mvanhorn/printing-press-library/releases/tag/twilio-jobs-pp-cli-current).
2. Double-click the `.mcpb` file. Claude Desktop opens and walks you through the install.

Requires Claude Desktop 1.0.0 or later. Pre-built bundles ship for macOS Apple Silicon (`darwin-arm64`) and Windows (`amd64`, `arm64`); for other platforms, use the manual config below.

<details>
<summary>Manual JSON config (advanced)</summary>

If you can't use the MCPB bundle (older Claude Desktop, unsupported platform), install the MCP binary and configure it manually.


Install the MCP binary from this CLI's published public-library entry or pre-built release.

Add to your Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "twilio-jobs-pp-cli": {
      "command": "twilio-jobs-pp-cli-pp-mcp"
    }
  }
}
```

</details>

## Quick Start

### 1. Install

See [Install](#install) above.

### 2. Verify Setup

```bash
twilio-jobs-pp-cli-pp-cli doctor
```

This checks your configuration.

### 3. Try Your First Command

```bash
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list
```

## Usage

Run `twilio-jobs-pp-cli-pp-cli --help` for the full command reference and flag list.

## Commands

### twilio-careers-jobs

Manage twilio careers jobs

- **`twilio-jobs-pp-cli-pp-cli twilio-careers-jobs get`** - Get job details
- **`twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list`** - List all job postings


## Output Formats

```bash
# Human-readable table (default in terminal, JSON when piped)
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list

# JSON for scripting and agents
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list --json

# Filter to specific fields
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list --json --select id,name,status

# Dry run — show the request without sending
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list --dry-run

# Agent mode — JSON + compact + no prompts in one flag
twilio-jobs-pp-cli-pp-cli twilio-careers-jobs list --agent
```

## Agent Usage

This CLI is designed for AI agent consumption:

- **Non-interactive** - never prompts, every input is a flag
- **Pipeable** - `--json` output to stdout, errors to stderr
- **Filterable** - `--select id,name` returns only fields you need
- **Previewable** - `--dry-run` shows the request without sending
- **Read-only by default** - this CLI does not create, update, delete, publish, send, or mutate remote resources
- **Offline-friendly** - sync/search commands can use the local SQLite store when available
- **Agent-safe by default** - no colors or formatting unless `--human-friendly` is set

Exit codes: `0` success, `2` usage error, `3` not found, `5` API error, `7` rate limited, `10` config error.

## Health Check

```bash
twilio-jobs-pp-cli-pp-cli doctor
```

Verifies configuration and connectivity to the API.

## Configuration

Config file: `~/.config/twilio-careers-pp-cli/config.toml`

Static request headers can be configured under `headers`; per-command header overrides take precedence.

## Troubleshooting
**Not found errors (exit code 3)**
- Check the resource ID is correct
- Run the `list` command to see available items

---

Generated by [CLI Printing Press](https://github.com/mvanhorn/cli-printing-press)

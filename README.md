# MakeSilicon

MakeSilicon is a tiny, no-frills scaffolder for FPGA/ASIC IP repositories. It creates a ready-to-use project skeleton (folders, Makefile, `init.sh`, README) so you can start designing immediately.

## Highlights

- One command to scaffold a new design under a chosen parent folder
- Sensible default directories for HDL work (src, sim, synth, tb, …)
- Simple templates copied into each new repo (customizable)
- Optional Git initialization
- Safe clean (warns if there are uncommitted or unpushed changes)
- Utility targets to list projects and clone a set of external repos

## Requirements

- GNU Make
- Git (only if you want Git repos auto-initialized)

## Install

Clone this repository:

```bash
git clone https://github.com/bugratufan/make-silicon.git
cd make-silicon
```

## Quick start

1) See available commands

```bash
make help
```

2) Create a new project (auto-suffixed if the name exists)

```bash
make create PROJECT=my_ip
```

This creates `ip_repos/my_ip/` with default subfolders:

```
src sim synth docs scripts tb constraints lib mem logs results
```

3) Skip Git initialization (optional)

```bash
make create PROJECT=my_ip GIT_INIT=no
```

4) List projects under the parent directory

```bash
make list
```

5) Remove a project (interactive safety check if it’s a Git repo)

```bash
make clean PROJECT=my_ip
```

## Configuration

Defaults live in `config.mk`:

- `PROJ_DIR` (default: `ip_repos`) – parent folder for generated projects
- `GIT_INIT` (default: `yes`) – set to `no` to skip `git init`
- `REPO_LIST` (default: `repos.txt`) – used by the `clone` target

You can override variables per-invocation, e.g. place projects elsewhere:

```bash
make create PROJECT=my_ip PROJ_DIR=/path/to/designs
```

### Custom directories

By default, these subfolders are created: `src sim synth docs scripts tb constraints lib mem logs results`.

Provide your own list with `DIRECTORIES` (comma-separated):

```bash
make create PROJECT=my_ip DIRECTORIES=src,sim,tb,docs
```

## Templates

On creation, the following files are copied into the project and customized:

- `README.md` – project-level README with the folder layout
- `init.sh` – your hook for any environment setup or generators
- `Makefile` – includes a basic `init` target that runs `./init.sh`
- `config.mk` – project-specific config stub

Placeholders like `{{PROJECT_NAME}}` are replaced with your project’s name.

## Cloning external IPs

List Git repositories in `repos.txt` (one per line), then run:

```bash
make clone
```

They will be cloned into `PROJ_DIR` (skips ones already present as Git repos).

## Notes

- If `PROJECT` already exists, a numeric suffix (`_1`, `_2`, …) is appended automatically.
- The `clean` target prompts before deletion if uncommitted or unpushed changes are detected.

## License

GPL-2.0. See [LICENSE](LICENSE).

## Contributing

Issues and PRs are welcome: https://github.com/bugratufan/make-silicon
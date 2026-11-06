# macOS Systems Lab

My notes on learning to inspect software on an Intel Mac. Working with the 1401 (NullMoth) 2.7.2 package taught me to break “will this run on my machine?” into smaller questions: What did I download? What does the package expect? What can I verify before running it?

## A case study: reading a Mac app bundle

On macOS 15.8.2 (x86_64), using zsh, I looked at the difference between a downloaded ZIP, the extracted .app, and the executable inside it. The bundle has a launcher under `Contents/MacOS`, metadata in `Info.plist`, and JavaScript, CSS, shell scripts, and hardware rule files under `Contents/Resources`. That layout gave me a practical way to navigate an unfamiliar release.

| Skill | Example from the package | What I learned |
| --- | --- | --- |
| Inspecting a release | The launcher and setup script are separate files. | I can locate the entry point and inspect setup steps before deciding to run them. |
| Reasoning about compatibility | GPU mapping, Metal device discovery, and runtime checks have distinct helpers. | A hardware identifier, an available graphics API, and a working runtime answer different questions. |
| Planning diagnostics | The package includes preflight checks, log capture, and an uninstaller. | I can plan what evidence to collect before a change and identify the proposed recovery path. |

## Try the inspection

From the directory containing the extracted app, these read-only commands report the host version, CPU architecture, package metadata, and launcher format:

```zsh
sw_vers -productVersion
uname -m
plutil -p "1401.app/Contents/Info.plist"
file "1401.app/Contents/MacOS/1401"
```

My working configuration pairs a zsh shell for local inspection with Codex and task-specific plugins for assisted work. I keep downloaded software separate from notes I intend to publish. This repository shares the inspection method; it contains no vendor binaries, machine logs, or private configuration. The case study covers package inspection only; hardware support and runtime behavior would need separate tests.

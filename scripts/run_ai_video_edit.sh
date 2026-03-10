#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <video_path> [--script script_path] [--intensity normal|more]" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENV_DIR="$SKILL_DIR/.venv"
PY="$VENV_DIR/bin/python"

if [ ! -x "$PY" ]; then
  python3 -m venv "$VENV_DIR"
  "$PY" -m pip install faster-whisper
fi

"$PY" "$SCRIPT_DIR/ai_video_edit.py" "$@"

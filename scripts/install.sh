#!/usr/bin/env bash
#
# Terminal Voice Companion - setup for macOS (Apple Silicon).
#
# Installs the local voice stack this project builds on, all running on your
# own machine:
#   - ffmpeg + portaudio   (audio capture and conversion)
#   - uv                   (Python tool runner)
#   - VoiceMode            (the MCP server Claude Code talks to)
#   - Whisper              (local speech to text, on port 2022)
#   - Kokoro               (local text to speech, on port 8880)
# and registers VoiceMode as an MCP server in Claude Code.
#
# Linux support is not here yet. Verified on macOS arm64 with VoiceMode 8.8.0.

set -euo pipefail

WHISPER_MODEL="${WHISPER_MODEL:-small}"   # base | small | medium | large-v2

echo "==> 1/6 Homebrew audio dependencies"
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh and re-run." >&2
  exit 1
fi
brew install ffmpeg portaudio

echo "==> 2/6 uv"
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# VoiceMode's bundled installer crashes on its Whisper step in 8.8.0 (it passes
# an unsupported --model flag), so install the core only and set up the local
# services by hand below, which is deterministic.
echo "==> 3/6 VoiceMode core"
uvx voice-mode-install --yes --skip-services

echo "==> 4/6 Whisper STT (model: ${WHISPER_MODEL})"
voicemode service install whisper
voicemode whisper model "${WHISPER_MODEL}"

echo "==> 5/6 Kokoro TTS"
voicemode service install kokoro || true   # safe if already installed

echo "==> 6/6 Start services and register with Claude Code"
voicemode service start whisper || true
voicemode service start kokoro || true
claude mcp add --scope user voicemode -- uvx voice-mode || true

echo
echo "Done. Verify with:  voicemode service status"
echo "Then start a NEW Claude Code session and ask it to talk."
echo "Use headphones: open-mic mode needs them so it does not hear itself."

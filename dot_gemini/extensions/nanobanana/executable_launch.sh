#!/bin/bash
# GEMINI_API_KEY is injected by ~/.agents/bin/gemini wrapper at CLI launch.
# This script just execs node — no duplicate 1Password auth needed.
exec node "$@"

#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/aiomni/omni-skills"
SKILLS=(
  engineering-task-system
  egui-screenshot
  writing-spec
)

if ! command -v npx >/dev/null 2>&1; then
  echo "Error: npx is required to install skills." >&2
  exit 1
fi

for skill in "${SKILLS[@]}"; do
  echo "Installing ${skill} from ${REPO}"
  npx --yes skills add "${REPO}" --skill "${skill}"
done

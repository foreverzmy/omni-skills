#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/aiomni/omni-skills"
SKILLS=(
  engineering-task-system
  egui-screenshot
  writing-spec
)

for skill in "${SKILLS[@]}"; do
  echo "Installing ${skill} from ${REPO}"
  npx skills add "${REPO}" --skill "${skill}"
done

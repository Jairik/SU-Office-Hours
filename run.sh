#!/usr/bin/env bash
set -euo pipefail

# Run Spring Boot backend and Vite frontend together, and clean up on exit.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACK_PID=""
FRONT_PID=""

cleanup() {
  echo "Stopping frontend/backend..."
  if [[ -n "${BACK_PID}" ]]; then
    kill "${BACK_PID}" 2>/dev/null || true
  fi
  if [[ -n "${FRONT_PID}" ]]; then
    kill "${FRONT_PID}" 2>/dev/null || true
  fi
}
trap cleanup EXIT INT TERM

pushd "${ROOT_DIR}/backend" >/dev/null
./gradlew bootRun &
BACK_PID=$!
popd >/dev/null

pushd "${ROOT_DIR}/frontend" >/dev/null
npm run dev -- --host &
FRONT_PID=$!
popd >/dev/null

wait

#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
test_build="$(mktemp -d "${TMPDIR:-/tmp}/notch-watch-connectivity.XXXXXX")"
trap 'rm -rf "$test_build"' EXIT
cd "$repo_root"

swiftc -module-cache-path "$test_build/ModuleCache" \
  -emit-library -emit-module -module-name WatchConnectivity \
  test/native/watch_connectivity_stub/WatchConnectivity.swift \
  -o "$test_build/libWatchConnectivity.dylib" \
  -emit-module-path "$test_build/WatchConnectivity.swiftmodule"

swiftc -I "$test_build" -L "$test_build" -lWatchConnectivity \
  -Xlinker -rpath -Xlinker "$test_build" \
  -module-cache-path "$test_build/ModuleCache" \
  ios/WatchShared/*.swift \
  ios/Runner/WatchCompanion/WatchPhoneInbox.swift \
  ios/Runner/WatchCompanion/WatchPhoneSession.swift \
  ios/NotchWatch/State/WatchQueueStore.swift \
  ios/NotchWatch/Services/WatchSession.swift \
  test/native/watch_connectivity/main.swift \
  -o "$test_build/watch-connectivity-tests"
"$test_build/watch-connectivity-tests"

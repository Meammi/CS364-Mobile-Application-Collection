#!/usr/bin/env bash
# Adds the Wuwa demo decks to the Flashcards app on a connected device/emulator.
# Needs: debug build installed from Android Studio, app opened once, USB debugging on.
# Usage: bash add-wuwa-decks.sh [device-serial]
set -euo pipefail

SDK="${ANDROID_HOME:-$LOCALAPPDATA/Android/Sdk}"
ADB="$SDK/platform-tools/adb"
SQLITE="$SDK/platform-tools/sqlite3"
PKG=com.example.flashcards
HERE="$(cd "$(dirname "$0")" && pwd)"
[ $# -ge 1 ] && ADB="$ADB -s $1"
STAMP=$(date +%Y%m%d-%H%M%S)
WORK="$HERE/backup-$STAMP"
mkdir -p "$WORK"

$ADB shell am force-stop $PKG
$ADB exec-out run-as $PKG cat databases/flashcards.db > "$WORK/flashcards_before.db"
[ -s "$WORK/flashcards_before.db" ] || { echo "No database: open the app once first."; exit 1; }

cp "$WORK/flashcards_before.db" "$WORK/flashcards_after.db"
"$SQLITE" "$WORK/flashcards_after.db" < "$HERE/wuwa_decks.sql"
"$SQLITE" "$WORK/flashcards_after.db" \
  "SELECT d.name || ': ' || COUNT(c._id) || ' cards' FROM decks d LEFT JOIN cards c ON c.deck_id = d._id GROUP BY d._id;"

LOCAL="$WORK/flashcards_after.db"
command -v cygpath > /dev/null && LOCAL="$(cygpath -w "$LOCAL")"   # Windows adb needs a Windows path
MSYS_NO_PATHCONV=1 $ADB push "$LOCAL" /data/local/tmp/fc_new.db > /dev/null
# replace only if the pushed copy is there and not empty
MSYS_NO_PATHCONV=1 $ADB shell "chmod 644 /data/local/tmp/fc_new.db && \
  run-as $PKG sh -c '[ -s /data/local/tmp/fc_new.db ] && cat /data/local/tmp/fc_new.db > databases/flashcards.db && rm -f databases/flashcards.db-journal' && \
  rm /data/local/tmp/fc_new.db"
$ADB exec-out run-as $PKG cat databases/flashcards.db | cmp -s - "$WORK/flashcards_after.db" \
  || { echo "Copy check failed. Old database is in $WORK/flashcards_before.db"; exit 1; }

echo "Done. Backup of the old database: $WORK/flashcards_before.db"

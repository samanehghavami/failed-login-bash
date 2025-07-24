#!/bin/bash

LOGFILE="/var/log/auth.log"
LASTLINEFILE="/tmp/last_failed_login_line"

CURRENT_LINE=$(wc -l < "$LOGFILE")
LAST_LINE=$(cat "$LASTLINEFILE" 2>/dev/null || echo 0)

msg=$(tail -n $((CURRENT_LINE - LAST_LINE)) "$LOGFILE" | grep "Failed password" | awk '{$1, $2, $3,print $(NF-3),}' | sort | uniq -c | sort -rn)

echo "$msg"
echo "$CURRENT_LINE" > "$LASTLINEFILE"

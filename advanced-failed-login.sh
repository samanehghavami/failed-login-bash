#!/bin/bash
#in this script i want to send an alert to telegram channel.
source ./.secrets
LASTLINEFILE=/tmp/line
LASTLINE=$(cat $LASTLINEFILE 2>dev/null || echo 0)
CURRENTLINE=$(wc -l </var/log/auth.log)
tail -n $($CURRENTLINE - $LASTLINE) /var/log/auth.log | grep Failed password | awk {'NF -3'}|sort|uniq -c|sort -nr > log.txt
msg=$(cat log.txt)
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
         -d chat_id="$CHAT_ID" \
         -d text="$msg"
done
echo "$CURRENT_LINE" > $LASTLINEFILE



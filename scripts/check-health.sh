#!/usr/bin/env bash

WEB_SERVERS=(
    "web-01:192.168.56.20"
    "web-02:192.168.56.21"
)

FAILED=0

echo "Checking backend health..."
echo "-------------------------"

for SERVER in "${WEB_SERVERS[@]}"; do
    NAME="${SERVER%%:*}"
    IP="${SERVER##*:}"
    URL="http://${IP}:3000/health"

    if HTTP_CODE=$(curl -sS -o /dev/null -w "%{http_code}" \
        --connect-timeout 3 "$URL"); then

        if [ "$HTTP_CODE" = "200" ]; then
            echo "$NAME ($IP): HEALTHY"
        else
            echo "$NAME ($IP): UNHEALTHY - HTTP $HTTP_CODE"
            FAILED=1
        fi
    else
        echo "$NAME ($IP): DOWN"
        FAILED=1
    fi
done

echo "-------------------------"

if [ "$FAILED" -eq 0 ]; then
    echo "All backend servers are healthy."
    exit 0
else
    echo "One or more backend servers failed health check."
    exit 1
fi

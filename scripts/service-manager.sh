#!/usr/bin/env bash

SERVICE_NAME="react-app"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {start|stop|restart|status}"
    exit 2
fi

ACTION="$1"

case "$ACTION" in
    start)
        sudo systemctl start "$SERVICE_NAME"
        echo "React service started."
        ;;

    stop)
        sudo systemctl stop "$SERVICE_NAME"
        echo "React service stopped."
        ;;

    restart)
        sudo systemctl restart "$SERVICE_NAME"
        echo "React service restarted."
        ;;

    status)
        sudo systemctl status "$SERVICE_NAME" --no-pager
        ;;

    *)
        echo "Error: Invalid action."
        echo "Usage: $0 {start|stop|restart|status}"
        exit 2
        ;;
esac

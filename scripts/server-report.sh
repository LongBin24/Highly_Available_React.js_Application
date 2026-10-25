#!/usr/bin/env bash

echo "======================================"
echo "       SERVER SYSTEM REPORT"
echo "======================================"

echo
echo "Hostname:"
hostname

echo
echo "IP Addresses:"
hostname -I

echo
echo "Uptime:"
uptime -p

echo
echo "Memory Usage:"
free -h

echo
echo "CPU Information:"
lscpu | grep -E 'Model name|CPU\(s\)' | head -n 2

echo
echo "Disk Usage:"
df -h /

echo
echo "Report generated at:"
date

echo "======================================"
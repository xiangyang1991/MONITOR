#!/bin/bash
pdsh -w 10.246.69.[1-245,248-251],10.246.68.[1-156],10.246.67.[170-203] "df -h 2>/dev/null | grep sda3"

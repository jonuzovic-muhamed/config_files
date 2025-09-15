#!/bin/bash

status=$(dnf check-update --quiet | wc -l)

if [ $status -gt 0 ]; then
  echo ""
fi

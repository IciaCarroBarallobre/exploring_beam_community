#!/bin/bash

while IFS='=' read -r key value; do
  if [[ ! -z "$key" && "$key" != \#* ]]; then
    # Trim quotes from the value if present
    value=$(echo "$value" | sed 's/^"//;s/"$//')
    flyctl secrets set $key=$value
  fi
done < .env
#!/bin/bash

pmsetString=$(pmset -g batt | grep -E "([0-9]+)\%; (.*?); " -o)
value=$(echo "$pmsetString" | cut -f1 -d'%' | xargs)
state=$(echo "$pmsetString" | cut -f2 -d';' | xargs)
state=${state:l}

echo "$state"
echo "$value"

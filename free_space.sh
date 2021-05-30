#!/bin/bash

df -H / | head -2 | tail -1 | awk '{print $4}'

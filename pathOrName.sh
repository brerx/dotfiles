#!/bin/bash

pwd="$1"
name="$2"
pwd=${pwd/#$HOME/\~};

if [[ -n $name ]]
then
    echo "$name"
else
    basename "$pwd"
fi



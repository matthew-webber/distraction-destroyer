#!/bin/bash

# targets=(); while read -r line; do targets+=(“$line”); done < <(cat targets.txt)
x=(); while read -r line; do x+=( “$line” ); done < <(seq 5)

echo "$x << targets yo"
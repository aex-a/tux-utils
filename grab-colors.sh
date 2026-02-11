#!/bin/bash
# I use this to theme the image I use in fastfetch so it matches the current pallete generated in pywal

. ~/.cache/wal/colors.sh

num="$1"
grep color"$num" ~/.cache/wal/colors.sh | cut -d \' -f 2 |  sed '15,19d' 
# comment above and uncomment below for the file output version
# grep color"$num" ~/.cache/wal/colors.sh | cut -d \' -f 2 |  sed '15,19d'  > colors.txt

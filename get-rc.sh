#!/bin/bash

total=0
posts=0

pages=$(curl -s "https://www.richardhandl.com/" | grep -A 1 '&#x02026;' | tail -1 | grep -Po '[0-9]*(?=<)')

for i in $(eval echo "{1..$pages}"); do
    if [[ $i == 1 ]]; then
        url="https://www.richardhandl.com/"
    else
        url="https://www.richardhandl.com/page/$i/"
    fi  
        
    echo -n "$i.."

    output=$(curl -s "$url")
        
    cigs=$(echo "$output" | grep -Paio '[0-9]*(?= cig.*r)')
        
    for cig in $cigs; do
        total="$(($total + $cig))"
        posts="$(($posts + 1))"
    done
done

printf "\n\n"

echo "Totalt har Richard rökt $total cigaretter."
echo "Det motsvarar ca. $(($total / $posts)) cigaretter / inlägg."

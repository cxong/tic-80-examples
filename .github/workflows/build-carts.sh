#!/bin/bash

declare -a exts=("lua" "moon" "wren" "js" "fnl")

for example in examples/*; do
    for ext in "${exts[@]}"; do
        cart="${example}/src.${ext}"
        if [ -f "$cart" ]; then
            ./.github/workflows/tic80 --cmd="load ${cart} & export html ${example}/${ext}.html & exit" --fs=. --cli
            mkdir $example/$ext
            unzip ${example}/${ext}.html.zip -d $example/$ext
            rm ${example}/${ext}.html.zip
        fi
    done
done

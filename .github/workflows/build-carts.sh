#!/bin/bash

declare -a exts=("lua" "moon" "wren" "js" "fnl")

for example in examples/*; do
    for ext in "${exts[@]}"; do
        cart="${example}/src.${ext}"
        if [ -f "$cart" ]; then
            ./.github/workflows/tic80 --cmd="load ${cart} & export html ${ext}.html & exit" --fs=. --cli
            unzip ${ext}.html.zip -d $example/$ext
            rm ${ext}.html.zip
        fi
    done
done

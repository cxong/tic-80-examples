#!/bin/bash
set -x

declare -a exts=("lua" "moon" "wren" "js" "fnl")

run_tic80_cart_cmd() {
    CART=$1
    CMD=$2
    ./.github/workflows/tic80 --fs=. --cli --cmd="load ${CART} & ${CMD} & exit"
}

for example in examples/*; do
    for ext in "${exts[@]}"; do
        cart="${example}/src.${ext}"
        if [ -f "$cart" ]; then
            # Retry building HTML from cart (occasionally fails)
            HTML_OUT=${example}/${ext}.html.zip
            for i in {1..5}; do
                run_tic80_cart_cmd $cart "export html ${example}/${ext}.html"
                if [ -f $HTML_OUT ]; then
                    break
                fi
            done
            if [ ! -f $HTML_OUT ]; then
                echo "Failed to build cart!"
                exit 1
            fi
            mkdir $example/$ext
            unzip $HTML_OUT -d $example/$ext
            rm $HTML_OUT
            # Save PNG
            run_tic80_cart_cmd $cart "save ${example}/cart.png"
            # Create post
            export BASE=$(basename ${example})
            export LANG=${ext}
            # TODO: get all variables from cart
            eval $(cat ${example}/meta.env) envsubst < _posts/template.md > _posts/2022-01-01-${BASE}.md
        fi
    done
done

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
            # Get metadata from cart: title, author, desc, site, license, version, script
            eval $(strings cart.tic | pcregrep -o1 -o2 --om-separator== "^(?:;;|\/\/|#|--) (\S+):\s*(\S+)$")

            # Check for required env vars
            if [[ -z "${title}" ]]; then
                echo "No title for ${cart}"
                continue
            fi
            if [[ -z "${desc}" ]]; then
                echo "No desc for ${cart}"
                continue
            fi
            if [[ -z "${script}" ]]; then
                echo "No author for ${cart}"
                continue
            fi

            # Retry building HTML from cart (occasionally fails)
            HTML_OUT=${example}/${script}.html.zip
            for i in {1..5}; do
                run_tic80_cart_cmd $cart "export html ${example}/${script}.html"
                if [ -f $HTML_OUT ]; then
                    break
                fi
            done
            if [ ! -f $HTML_OUT ]; then
                echo "Failed to build cart!"
                exit 1
            fi
            mkdir $example/$script
            unzip $HTML_OUT -d $example/$script
            rm $HTML_OUT

            # Save PNG
            run_tic80_cart_cmd $cart "save ${example}/cart.png"

            # Create post
            export TITLE=$title
            export DESC=$desc
            export BASE=$(basename ${example})
            export LANG=${script}
            envsubst < _posts/template.md > _posts/2022-01-01-${BASE}.md
        fi
    done
done

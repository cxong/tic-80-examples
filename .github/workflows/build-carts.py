#!/usr/bin/env python3
import html
import os
import re
import subprocess
import zipfile
from pathlib import Path
from typing import Iterable

EXTS = {"lua", "moon", "wren", "js", "fnl"}
META_PATTERN = re.compile(r"^(?:;;|\/\/|#|--) (\S+):\s*(.+)\s*$")
REQ_METAS = {"title", "desc", "script"}


def run_tic80_cart_cmd(cart: Path, cmd: str):
    os.system(f'./.github/workflows/tic80 --fs=. --cli --cmd="load {cart} & {cmd} & exit"')


def build_cart(example: Path, cart: Path) -> bool:
    # Get metadata from cart: title, author, desc, site, license, version, script
    meta = {}
    for line in subprocess.check_output(["strings", str(cart)]).split(b"\n"):
        match = META_PATTERN.match(line.decode("utf-8"))
        if match:
            meta[match.group(1)] = match.group(2)
    # Check for required env vars
    for req_meta in REQ_METAS:
        if req_meta not in meta:
            print(f"No title for {cart}")
            return False

    # Retry building HTML from cart (occasionally fails)
    html_out = example / f"{meta['script']}.html.zip"
    for i in range(5):
        run_tic80_cart_cmd(cart, f"export html {example}/{meta['script']}.html")
        if html_out.exists():
            break
    if not html_out.exists():
        print(f"Failed to build {cart}!")
        return False
    out_dir = example / meta["script"]
    out_dir.mkdir(parents=True)
    with zipfile.ZipFile(html_out) as file:
        file.extractall(out_dir)
    html_out.unlink()

    # Save PNG
    run_tic80_cart_cmd(cart, f"save {example}/cart.png")

    # Add code
    code = "See cart for code..."
    if cart.stem == "src":
        with open(cart) as file:
            code = file.read()

    # Create post
    with open(Path("_posts") / "template.md") as file:
        contents = file.read().format(**meta, base=example.stem, code=html.escape(code))
    with open(Path("_posts") / f"2022-01-01-{example.stem}.md", "w") as file:
        file.write(contents)


def get_cart_tags(cart: Path) -> Iterable[str]:
    # Get metadata from cart: title, author, desc, site, license, version, script
    for line in subprocess.check_output(["strings", str(cart)]).split(b"\n"):
        match = META_PATTERN.match(line.decode("utf-8"))
        if match:
            meta = match.group(1)
            if meta == "tags":
                return match.group(2).split()
    return []


all_tags = set()

for example in Path("carts").iterdir():
    if not example.is_dir():
        continue
    for ext in EXTS:
        # Try both "src.moon" and "moon.tic"
        tags = []
        cart = example / f"src.{ext}"
        if cart.exists():
            build_cart(example, cart)
            tags = get_cart_tags(cart)
        else:
            cart = example / f"{ext}.tic"
            if cart.exists():
                build_cart(example, cart)
                tags = get_cart_tags(cart)
        for tag in tags:
            all_tags.add(tag)

Path("tag").mkdir(exist_ok=True)
for tag in all_tags:
    # Create tag page
    with open(Path("tag") / f"{tag}.md", "w") as file:
        file.write(f"""---
layout: carts
title: "Tag: {tag}"
robots: noindex
---
{{% include carts.html tag-name="{tag}" %}}
""")
    print(f"Created tag page {tag}")

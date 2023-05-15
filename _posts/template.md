---
layout: example
title: {title}
desc: {desc}
tags: {tags}
lang: {script}
base: {base}
---

<div class="text-center">
  <div class="cart-frame">
    <iframe id="cart" src="{{{{ site.baseurl }}}}/carts/{base}/{script}/index.html" title="Example cart"
  width="768" height="432"></iframe>
  </div>
</div>

<div class="input-group">
  <pre><code class="code language-{script}">{code}</code></pre>
</div>

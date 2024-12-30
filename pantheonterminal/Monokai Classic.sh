#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Monokai Classic'
cursor-color='#c0c1b5'
foreground='#fdfff1'
background='rgba(39,40,34,.95)'
palette='#272822:#f92672:#a6e22e:#e6db74:#fd971f:#ae81ff:#66d9ef:#fdfff1:#6e7066:#f92672:#a6e22e:#e6db74:#fd971f:#ae81ff:#66d9ef:#fdfff1'
COLORS

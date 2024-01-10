#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='terafox'
cursor-color='#e6eaea'
foreground='#e6eaea'
background='rgba(21,37,40,.95)'
palette='#2f3239:#e85c51:#7aa4a1:#fda47f:#5a93aa:#ad5c7c:#a1cdd8:#ebebeb:#4e5157:#eb746b:#8eb2af:#fdb292:#73a3b7:#b97490:#afd4de:#eeeeee'
COLORS

#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Salem'
cursor-color='#f4e2a6'
foreground='#e6dcc1'
background='rgba(15,42,51,.95)'
palette='#9daeb3:#e36b61:#94c17f:#e6bc62:#78a9f0:#b477cf:#69c9c7:#e6dcc1:#b6c5c9:#f06d5f:#a9d18c:#f4d58b:#94b9f4:#c98de0:#8bd9d7:#fff4da'
COLORS

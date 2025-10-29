#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='owl'
cursor-color='#dedede'
foreground='#dedede'
background='rgba(47,43,44,.95)'
palette='#302c2c:#5a5a5a:#989898:#cacaca:#656565:#b1b1b1:#7f7f7f:#dedede:#5d595b:#da5b2c:#989898:#cacaca:#656565:#b1b1b1:#7f7f7f:#ffffff'
COLORS

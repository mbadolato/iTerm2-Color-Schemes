#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Cursor Light'
cursor-color='#252525'
foreground='#252525'
background='rgba(243,243,243,.95)'
palette='#252525:#cf2d56:#1f8a65:#a16900:#3c7cab:#b8448b:#4c7f8c:#afafaf:#5c5c5c:#e75e78:#55a583:#c08532:#6299c3:#d06ba6:#6f9ba6:#ffffff'
COLORS

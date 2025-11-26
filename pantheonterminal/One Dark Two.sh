#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='One Dark Two'
cursor-color='#e6e6e6'
foreground='#e6e6e6'
background='rgba(33,37,43,.95)'
palette='#1d1f23:#e27881:#98c379:#eac786:#71b9f4:#c88bda:#62bac6:#c9ccd3:#4a505a:#e68991:#a8cc8e:#edcf97:#8dc7f6:#d3a2e2:#78c4ce:#e6e6e6'
COLORS

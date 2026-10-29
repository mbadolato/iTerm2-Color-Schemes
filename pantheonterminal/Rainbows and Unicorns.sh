#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Rainbows and Unicorns'
cursor-color='#fcb827'
foreground='#e6e3d8'
background='rgba(14,14,19,.95)'
palette='#23232d:#e0453f:#62bb47:#fcb827:#1d9be3:#bb62c0:#35c9be:#c9c6bc:#6f6e7d:#f5821f:#8ad46b:#ffd35c:#5db9f0:#d68adb:#6fddd3:#fffdf5'
COLORS

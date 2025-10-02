#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Builtin Tango Light'
cursor-color='#000000'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#cc0000:#4e9a06:#c4a000:#3465a4:#75507b:#06989a:#babeb6:#555753:#ef2929:#7dd527:#d6c329:#729fcf:#ad7fa8:#27d5d5:#eeeeec'
COLORS

#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Builtin Tango Light'
cursor-color='#000000'
foreground='#000000'
background='rgba(255,255,255,.95)'
palette='#000000:#cc0000:#4e9a06:#c4a000:#3465a4:#75507b:#06989a:#d3d7cf:#555753:#ef2929:#8ae234:#fce94f:#729fcf:#ad7fa8:#34e2e2:#eeeeec'
COLORS

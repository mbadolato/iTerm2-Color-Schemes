#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Ubuntu'
cursor-color='#bbbbbb'
foreground='#eeeeec'
background='rgba(48,10,36,.95)'
palette='#2e3436:#cc0000:#4e9a06:#c4a000:#3465a4:#75507b:#06989a:#d3d7cf:#555753:#ef2929:#8ae234:#fce94f:#729fcf:#ad7fa8:#34e2e2:#eeeeec'
COLORS

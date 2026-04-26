#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Claude Dark'
cursor-color='#d97757'
foreground='#e5e4e1'
background='rgba(38,38,36,.95)'
palette='#888681:#d47563:#9aca86:#e8c96b:#6a9bcc:#9b87f5:#3cbe8c:#e2e1da:#a6a59b:#f4a9a9:#a8d166:#fab319:#9fc5f4:#f3aac5:#79d7b3:#efeeeb'
COLORS

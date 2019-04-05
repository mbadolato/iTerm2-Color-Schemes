#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='PencilLight'
cursor-color='#20bbfc'
foreground='#424242'
background='rgba(241,241,241,.95)'
palette='#212121:#c30771:#10a778:#a89c14:#008ec4:#523c79:#20a5ba:#d9d9d9:#424242:#fb007a:#5fd7af:#f3e430:#20bbfc:#6855de:#4fb8cc:#f1f1f1'
COLORS

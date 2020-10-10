#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='vscode-dark'
cursor-color='#9cdcfe'
foreground='#dcdcdc'
background='rgba(30,30,30,.95)'
palette='#000000:#ce9178:#6a9955:#dcdcaa:#569cd6:#c586c0:#8db9e2:#eaeaea:#a6a6a6:#d16969:#b5cea8:#cd9731:#6799e6:#c586c0:#9cdcfe:#d4d4d4'
COLORS

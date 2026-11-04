#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Edge Light'
cursor-color='#3a8b84'
foreground='#4b505b'
background='rgba(250,250,250,.95)'
palette='#fafafa:#d05858:#608e32:#be7e05:#5079be:#b05ccc:#3a8b84:#8790a0:#afb8c2:#e17373:#76af6f:#deb974:#6996e0:#bf75d6:#5dbbc1:#7e869b'
COLORS

#!/bin/bash
dconf load /org/pantheon/terminal/settings/ <<COLORS
[/]
name='Material'
cursor-color='#16afca'
foreground='#232322'
background='rgba(234,234,234,.95)'
palette='#212121:#b7141f:#457b24:#f6981e:#134eb2:#560088:#0e717c:#efefef:#424242:#e83b3f:#7aba3a:#ffea2e:#54a4f3:#aa4dbc:#26bbd1:#d9d9d9'
COLORS

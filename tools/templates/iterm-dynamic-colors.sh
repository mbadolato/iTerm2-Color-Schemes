#!/bin/sh
# {{ scheme_name }}
printf "\033]P0{{ Ansi_0_Color.hex }}\033\\"
printf "\033]P1{{ Ansi_1_Color.hex }}\033\\"
printf "\033]P2{{ Ansi_2_Color.hex }}\033\\"
printf "\033]P3{{ Ansi_3_Color.hex }}\033\\"
printf "\033]P4{{ Ansi_4_Color.hex }}\033\\"
printf "\033]P5{{ Ansi_5_Color.hex }}\033\\"
printf "\033]P6{{ Ansi_6_Color.hex }}\033\\"
printf "\033]P7{{ Ansi_7_Color.hex }}\033\\"
printf "\033]P8{{ Ansi_8_Color.hex }}\033\\"
printf "\033]P9{{ Ansi_9_Color.hex }}\033\\"
printf "\033]Pa{{ Ansi_10_Color.hex }}\033\\"
printf "\033]Pb{{ Ansi_11_Color.hex }}\033\\"
printf "\033]Pc{{ Ansi_12_Color.hex }}\033\\"
printf "\033]Pd{{ Ansi_13_Color.hex }}\033\\"
printf "\033]Pe{{ Ansi_14_Color.hex }}\033\\"
printf "\033]Pf{{ Ansi_15_Color.hex }}\033\\"
printf "\033]Pg{{ Foreground_Color.hex }}\033\\"
printf "\033]Ph{{ Background_Color.hex }}\033\\"
printf "\033]Pl{{ Cursor_Color.hex }}\033\\"
{% if Selection_Color %}
printf "\033]Pj{{ Selection_Color.hex }}\033\\"
{% endif %}
{% if Selected_Text_Color %}
printf "\033]Pk{{ Selected_Text_Color.hex }}\033\\"
{% endif %}
{% if Bold_Color %}
printf "\033]Pi{{ Bold_Color.hex }}\033\\"
{% endif %}

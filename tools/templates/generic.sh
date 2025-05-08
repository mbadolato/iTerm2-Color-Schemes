#!/bin/sh
# {{ scheme_name }}

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "{{Ansi_0_Color.hexshell}}"
put_template 1  "{{Ansi_1_Color.hexshell}}"
put_template 2  "{{Ansi_2_Color.hexshell}}"
put_template 3  "{{Ansi_3_Color.hexshell}}"
put_template 4  "{{Ansi_4_Color.hexshell}}"
put_template 5  "{{Ansi_5_Color.hexshell}}"
put_template 6  "{{Ansi_6_Color.hexshell}}"
put_template 7  "{{Ansi_7_Color.hexshell}}"
put_template 8  "{{Ansi_8_Color.hexshell}}"
put_template 9  "{{Ansi_9_Color.hexshell}}"
put_template 10 "{{Ansi_10_Color.hexshell}}"
put_template 11 "{{Ansi_11_Color.hexshell}}"
put_template 12 "{{Ansi_12_Color.hexshell}}"
put_template 13 "{{Ansi_13_Color.hexshell}}"
put_template 14 "{{Ansi_14_Color.hexshell}}"
put_template 15 "{{Ansi_15_Color.hexshell}}"

color_foreground="{{Foreground_Color.hexshell}}"
color_background="{{Background_Color.hexshell}}"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
{% set iterm_codes = {
    'g': Foreground_Color    ,
    'h': Background_Color    ,
    'i': Bold_Color          ,
    'j': Selection_Color     ,
    'k': Selected_Text_Color ,
    'l': Cursor_Color        ,
    'm': Cursor_Text_Color   ,
} %}
{% for k, v in iterm_codes.items() %}
  put_template_custom P{{ k }} "{{ v.hex }}"
{% endfor %}
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background

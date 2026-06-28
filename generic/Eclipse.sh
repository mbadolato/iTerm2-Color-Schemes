#!/bin/sh
# Eclipse

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
put_template 0  "0a/0d/12"
put_template 1  "ff/63/66"
put_template 2  "85/df/5e"
put_template 3  "f1/c6/55"
put_template 4  "5f/b9/ff"
put_template 5  "ce/a5/ff"
put_template 6  "3a/dd/c4"
put_template 7  "b7/c0/ce"
put_template 8  "5c/66/75"
put_template 9  "ff/86/88"
put_template 10 "a0/ec/7e"
put_template 11 "fa/d7/7c"
put_template 12 "84/cc/ff"
put_template 13 "dd/bf/ff"
put_template 14 "68/ea/d3"
put_template 15 "f4/f8/fd"

color_foreground="dc/e3/ed"
color_background="0e/11/16"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dce3ed"
  put_template_custom Ph "0e1116"
  put_template_custom Pi "dce3ed"
  put_template_custom Pj "25324a"
  put_template_custom Pk "5a5e62"
  put_template_custom Pl "f6c45f"
  put_template_custom Pm "0e1116"
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

#!/bin/sh
# Nebula Drift

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
put_template 0  "1a/0e/38"
put_template 1  "ff/5c/8d"
put_template 2  "66/e6/a8"
put_template 3  "ff/cb/6b"
put_template 4  "7c/9b/ff"
put_template 5  "c7/7d/ff"
put_template 6  "57/e6/f0"
put_template 7  "c8/c6/e8"
put_template 8  "5c/5a/88"
put_template 9  "ff/5c/8d"
put_template 10 "66/e6/a8"
put_template 11 "ff/9e/64"
put_template 12 "7c/9b/ff"
put_template 13 "c7/7d/ff"
put_template 14 "57/e6/f0"
put_template 15 "e2/e0/fa"

color_foreground="e2/e0/fa"
color_background="0a/04/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e2e0fa"
  put_template_custom Ph "0a0420"
  put_template_custom Pi "e2e0fa"
  put_template_custom Pj "221645"
  put_template_custom Pk "4a4460"
  put_template_custom Pl "d58bff"
  put_template_custom Pm "0a0420"
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

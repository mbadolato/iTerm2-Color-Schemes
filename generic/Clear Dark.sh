#!/bin/sh
# Clear Dark

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
put_template 0  "35/42/4c"
put_template 1  "b4/56/48"
put_template 2  "6c/aa/71"
put_template 3  "c4/ac/62"
put_template 4  "6d/96/b4"
put_template 5  "bd/7b/cd"
put_template 6  "7c/cb/cd"
put_template 7  "de/e5/eb"
put_template 8  "46/5c/6d"
put_template 9  "df/6c/5a"
put_template 10 "79/be/7e"
put_template 11 "e5/c8/72"
put_template 12 "67/b5/ed"
put_template 13 "d3/89/e5"
put_template 14 "84/dd/e0"
put_template 15 "e5/ef/f5"

color_foreground="e6/e6/e6"
color_background="21/27/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e6e6"
  put_template_custom Ph "212734"
  put_template_custom Pi "f0f0f0"
  put_template_custom Pj "334e5e"
  put_template_custom Pk "6e7380"
  put_template_custom Pl "9d9d9d"
  put_template_custom Pm "212734"
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

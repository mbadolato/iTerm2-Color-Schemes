#!/bin/sh
# Everblush

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
put_template 0  "23/2a/2d"
put_template 1  "e5/74/74"
put_template 2  "8c/cf/7e"
put_template 3  "e5/c7/6b"
put_template 4  "67/b0/e8"
put_template 5  "c4/7f/d5"
put_template 6  "6c/bf/bf"
put_template 7  "b3/b9/b8"
put_template 8  "2d/34/37"
put_template 9  "ef/7e/7e"
put_template 10 "96/d9/88"
put_template 11 "f4/d6/7a"
put_template 12 "71/ba/f2"
put_template 13 "ce/89/df"
put_template 14 "67/cb/e7"
put_template 15 "bd/c3/c2"

color_foreground="da/da/da"
color_background="14/1b/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dadada"
  put_template_custom Ph "141b1e"
  put_template_custom Pi "dadada"
  put_template_custom Pj "141b1e"
  put_template_custom Pk "dadada"
  put_template_custom Pl "dadada"
  put_template_custom Pm "141b1e"
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

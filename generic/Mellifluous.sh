#!/bin/sh
# Mellifluous

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
put_template 0  "1a/1a/1a"
put_template 1  "d2/93/93"
put_template 2  "b3/b3/93"
put_template 3  "cb/aa/89"
put_template 4  "a8/a1/be"
put_template 5  "b3/9f/b0"
put_template 6  "c0/af/8c"
put_template 7  "da/da/da"
put_template 8  "5b/5b/5b"
put_template 9  "c9/59/54"
put_template 10 "82/80/40"
put_template 11 "a6/79/4c"
put_template 12 "5a/65/99"
put_template 13 "9c/69/95"
put_template 14 "74/a3/9e"
put_template 15 "ff/ff/ff"

color_foreground="da/da/da"
color_background="1a/1a/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dadada"
  put_template_custom Ph "1a1a1a"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "2d2d2d"
  put_template_custom Pk "c0af8c"
  put_template_custom Pl "bfad9e"
  put_template_custom Pm "1a1a1a"
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

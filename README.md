# st - simple terminal (customized by mbf)
st is a simple terminal emulator for X which sucks less. I make it suck more
with my own customization.

## Modifications

**clipboard** - selecting will be sent to the primary selection and the
   clipboard. Not exactly the same as the __clipboard__ patch, which seems to
   raise errors for me.

**scrollback** - All three patches in ![patches/scrollback](https://st.suckless.org/patches/scrollback/) were applied.

   - Scroll back using Shift+{PageUp, PageDown}
   - Scroll back using Shift+MouseWheel
   - Scroll using just Mousewheel

**spoiler** - Patch in 
   ![patches/spoiler](https://st.suckless.org/patches/spoiler/) was applied. Use inverted default bg/fg colors for selection when bg/fg are the same. THis allows you to see the spoiler.

**externalpipe** - Patch in ![patches/externalpipe](https://st.suckless.org/patches/externalpipe/) was applied. This allows reaing and writing st's screen through a pipe.

**specchar** - My own implementation which spawns a dmenu with special
characters/strings and inserts the selection. An alternative/complement to
things like xcompose.

**noboldcolors** - Patch in
![patches/solarized](https://st.suckless.org/patches/solarized/) called
`st-no_bold_colors-20170623-b331da5.diff` was applied. This makes separates
bold colors from the 8-15 colors. This allows you to combine any of the first
16 colors with normal/bold types.

## Customization

Below I will share my most important configurations (`config.h`).

New commands:
   * **openurlcmd** -- search for urls in screen, show via dmenu, and open
                   selection in firefox.

   * **copyurlcmd** -- same as **openurlcmd**, but send url to clipboard

   * specchar -- run **listspecchars** command (see below) and show list of
                 special characters in dmenu. Insert selection to the terminal
                 cursor.

New bindings:
   * **Shift-PageUp**       -- scroll up.
   * **Shift-PageDown**     -- scroll down.
   * **Ctrl-Shift-u**       -- run openurlcmd().
   * **Ctrl-Shift-j**       -- run copyurlcmd().
   * **Ctrl-Shift-s**       -- run specchar().
   * **Ctrl-Shift-minus**   -- decrease font size. 
   * **Ctrl-Shift-plus**    -- increase font size.
   * **Ctrl-Shift-0**       -- reset to default font size.

Expanded word delimiters to:
```
" `'\"()[]{}<>"
```

Colors are left as default on config.def.h. However, config.h has my personal
theme. It's a weird one unless you use my dotfiles :P.

ascii_printable is changed to handle wide characters.

## Requirements

In order to build st you need the `Xlib` header files.

To run the **openurlcmd** and **copyurlcmd**, you need `xurls`, `dmenu`, `xargs`, and `xclip`.

To run **specchar** you need to have my listspecchars script in `PATH`. This
script merely returns a list of special characters with a `keywords
: symbol` syntax. **keywords** are words that you use to filter the list of
strings. **symbol** is the symbol/string that will be inserted. The colon **:**
is used as a delimiter and hard-coded into the specchar() function. Otherwise
the whitespace is unimportant. See below an example script `listspecchar` that
reads from the file (shown also below) called `special_characters_list`.

You can find my script in ![here](https://github.com/mbfraga/scripts). I 
generally clone this repo to `$HOME/gitland/scripts` and add it to `PATH`.

**listspecchar**:
```sh
#!/bin/sh
root_path="$( cd "$( dirname "$0" )" && pwd )"
cat "$(dirname "$0")/special_character_list" # special characters file should
                                             # be placed in the same directory.
```

**special_character_list**:
```txt
alpha   g-a     :α

smiley dunno4 shrug4       : ┐('～`；)┌
copyright          : ©
degrees            : °
```



## Installation

1. Clone repository `git clone https://github.com/mbfraga/st`

2. Checkout 'mine' branch `git checkout mine`

2. Edit config.mk to match your local setup (optional).

3. Compile and install
   ```bash
   I use the following commands to install st:
   make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11
   make PREFIX=/usr TERMINFO="$pkgdir/usr/share/terminfo" install
   install -Dm644 LICENSE "/usr/share/licenses/st/LICENSE"
   install -Dm644 LICENSE "/usr/share/doc/st/README"

   tic -sx st.info
   ```




## Credits
Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.


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

```C
char font[] = "DejaVu Sans Mono:pixelsize=14:antialias=true:autohint=true, Noto
Sans Kannada:pixelsize=14;antialias=true;autohint=true, Noto Emoji:style=Regular:pixelsize=26:antialias=true:hinting=true";
int borderpx = 3;

// Show urls in dmenu and open selection
static char *openurlcmd[] = { "/bin/sh", "-c",
      "xurls \
         | tac \
         | dmenu -l 10 -fn 'DejaVu Sans Mono-10' -p 'url:' -w $1 \
         | xargs -r firefox",
      "externalpipe", winid, NULL };

// Show urls in dmenu and yank selection
static char *copyurlcmd[] = { "/bin/sh", "-c",
      "xurls \
         | tac \
         | dmenu -l 10 -fn 'DejaVu Sans Mono-10' -p 'url:' -w $1 \
         | xclip -i -selection clipboard",
      "externalpipe", winid, NULL };

// Fix kerning.
float cwscale = 0.9;

// Add word delimiters
static char worddelimiters[] = " `'\"()[]{}<>";

//colors
const char *colorname[] = {
	/* 8 normal colors */
   "#191a1d",
   "#f3b2ab",
   "#bad260",
   "#eac58d",
   "#c6e5f8",
   "#e4c6ed",
   "#c6f3e6",
   "#5a6373",

	/* 8 bright colors */
   "#333841",
   "#ea4439",
   "#50763d",
   "#fab81d",
   "#446fa6",
   "#84678f",
   "#4f7b6c",
   "#f4efe3",

   [255] = 0,
};

unsigned int defaultfg = 15;
unsigned int defaultbg = 0;
unsigned int defaultcs = 15;
unsigned int defaultrcs = 0;


Shortcut shortcuts[] = {
...
	{ TERMMOD,              XK_plus,        zoom,           {.f = +1} },
	{ TERMMOD,              XK_Prior,       zoom,           {.f = +1} },
	{ TERMMOD,              XK_underscore,  zoom,           {.f = -1} },
	{ TERMMOD,              XK_Next,        zoom,           {.f = -1} },
	{ TERMMOD,              XK_Home,        zoomreset,      {.f =  0} },
	{ TERMMOD,              XK_C,           clipcopy,       {.i =  0} },
	{ TERMMOD,              XK_V,           clippaste,      {.i =  0} },
	{ TERMMOD,              XK_Y,           selpaste,       {.i =  0} },
	{ TERMMOD,              XK_Num_Lock,    numlock,        {.i =  0} },
	{ TERMMOD,              XK_I,           iso14755,       {.i =  0} },
	{ TERMMOD,              XK_S,           specchar,       {.i =  0} },
	{ TERMMOD,              XK_U,  externalpipe,   {.v = openurlcmd } },
	{ TERMMOD,              XK_J,  externalpipe,   {.v = copyurlcmd } },
	{ ShiftMask,            XK_Page_Up,     kscrollup,      {.i = -1} },
	{ ShiftMask,            XK_Page_Down,   kscrolldown,    {.i = -1} },

...
};
```


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

Edit config.mk to match your local setup (st is installed into
the /usr/local namespace by default).

```bash
tic -sx st.info
```




## Credits
Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.


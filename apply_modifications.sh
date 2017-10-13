#!/bin/sh

function _exit () {

   printf "[failed]\n"
   echo "exiting..."
   exit 1

}

function _ok () {

   printf "[OK]\n"

}

printf "Applying clipboard patch..."
git apply st-clipboard-20170925-b1338e9.diff && _ok || _exit

printf "Applying scrollback patch..."
git apply st-scrollback-20170329-149c0d3.diff && _ok || _exit

printf "Applying scrollback-mouse patch..."
git apply st-scrollback-mouse-20170427-5a10aca.diff && _ok || _exit

printf "Applying scrollback-mouse-altscreen patch..."
git apply st-scrollback-mouse-altscreen-20170427-5a10aca.diff && _ok || _exit

printf "Applying spoiler patch..."
git apply st-spoiler-20170802-e2ee5ee.diff && _ok || _exit

printf "Applying externalpipe patch..."
git apply st-externalpipe-20170608-b331da5.diff && _ok || _exit

printf "Applying specchar patch..."
git apply st-specchar-20170113-0ac685f.diff && _ok || _exit

printf "Applying no_bold_colors patch..."
git apply st-no_bold_colors-20170623-b331da5.diff && _ok || _exit



printf "Setting CC to cc"
sed -i "s|# CC = c99|CC = cc|" config.mk


#EOF

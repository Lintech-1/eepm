#!/bin/sh -x

# It will be run with two args: buildroot spec
BUILDROOT="$1"
SPEC="$2"

PRODUCT=discord
PRODUCTCUR=Discord
PRODUCTDIR=/opt/$PRODUCT

. $(dirname $0)/common-chromium-browser.sh

move_to_opt

fix_chrome_sandbox

install_deps

subst '1iAutoProv:no' $SPEC

mkdir -p $BUILDROOT/usr/bin/
ln -sf $PRODUCTDIR/Discord $BUILDROOT/usr/bin/$PRODUCT
ln -sf $PRODUCTDIR/discord.desktop $BUILDROOT/usr/share/applications/discord.desktop
ln -sf $PRODUCTDIR/discord.png $BUILDROOT/usr/share/pixmaps/discord.png

fix_desktop_file /usr/share/discord/Discord $PRODUCT


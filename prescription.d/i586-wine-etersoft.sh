#!/bin/sh

MAIN=wine-etersoft

[ "$1" != "--run" ] && echo "Install 32 bit $MAIN packages on 64 bit system" && exit

[ "$($DISTRVENDOR -d)" != "ALTLinux" ] && echo "Only ALTLinux is supported" && exit 1
[ "$($DISTRVENDOR -a)" != "x86_64" ] && echo "Only x86_64 is supported" && exit 1

# Устанавливаем wine
epmi lib$MAIN i586-$MAIN i586-lib$MAIN i586-lib$MAIN-gl || exit

# Доставляем пропущенные модули (подпакеты) для установленных 64-битных
epm prescription i586-fix

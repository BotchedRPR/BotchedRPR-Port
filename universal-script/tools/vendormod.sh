#!/bin/bash

function menu()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BotchedRPR-Port"
TITLE="Vendor Mods"
MENU="Choose one of the following options:"

OPTIONS=(1 "Cleanup common"
         2 "Make device packages"
         3 "Open priviliged dolphin"
         4 "Exit")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
}

function pause(){
   read -p "$*"
}

function clean()
{
    while read p; do
        sudo rm -r ../vendor/"$p"
    done < diff

    pause 'Press [Enter] key to continue...'
}

function makedevpkg()
{
    while read a; do
        sudo mkdir --parents "$2""$a"
    done < dirlist
    while read b; do
        sudo cp -rp "$1""$b" "$2""$b"
    done < diff
}
function makepkgs()
{
        HDIR="/home/bochenek"
        C1SDIR="$HDIR""/Desktop/vendor_refs/N205G/ven/"
        C1SLTEDIR="$HDIR""/Desktop/vendor_refs/N204G/super/vendor/"
        C2SLTEDIR="$HDIR""/Desktop/vendor_refs/N20U4G/super/vendor/"
        C2SDIR="$HDIR""/Desktop/vendor_refs/N20U5G/sup/ven/"

        C1SOUTDIR="../specific/vendor_packages/c1s/"
        C1SLTEOUTDIR="../specific/vendor_packages/c1slte/"
        C2SLTEOUTDIR="../specific/vendor_packages/c2slte/"
        C2SOUTDIR="../specific/vendor_packages/c2s/"
        makedevpkg "$C1SDIR" "$C1SOUTDIR"
        pause 'Finished making c1s package'
        clear
        makedevpkg "$C1SLTEDIR" "$C1SLTEOUTDIR"
        pause 'Finished making c1slte package'
        clear
        makedevpkg "$C2SLTEDIR" "$C2SLTEOUTDIR"
        pause 'Finished making c2slte package'
        clear
        makedevpkg "$C2SDIR" "$C2SOUTDIR"
        pause 'Finished making c2slte package'
        clear
}

function check()
{
menu
case $CHOICE in
        1)
            clean
            ;;
        2)
            makepkgs
            ;;
        3)
            pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dolphin .
            ;;
        4)
            exit
            ;;
esac
}

while true
do
    check
done



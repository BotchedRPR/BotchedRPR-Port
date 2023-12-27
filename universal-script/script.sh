#!/bin/bash

function menu()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BotchedRPR-Port"
TITLE="OneUI 6 - cnx series"
MENU="Choose one of the following options:"

OPTIONS=(1 "Prepare"
         2 "Unmount"
         3 "Make OPList"
         4 "Make zip"
         5 "Exit")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
}

function mount()
{
            sudo mount system.img system
            sudo mount vendor.img vendor
            cd tools
            ./vendormod.sh
            cd ..
}

function unmount()
{
            sudo umount -l system
            sudo umount -l vendor
            echo -ne '#####                     (33%)\r'
            e2fsck -f system.img
            e2fsck -f vendor.img
            echo -ne '#############             (66%)\r'
            resize2fs -M system.img
            resize2fs -M system.img
            resize2fs vendor.img 1500M
            echo -ne '#######################   (100%)\r'
            echo -ne '\n'
}


function check()
{
menu
case $CHOICE in
        1)
            mount
            ;;
        2)
            unmount
            ;;
        3)
            oplist
            ;;
        4)
            echo "placeholder"
            ;;
        5)
            exit
            ;;
esac
}

while true
do
    check
done



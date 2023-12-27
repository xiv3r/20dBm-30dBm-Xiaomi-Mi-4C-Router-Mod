#  Xiaom Mi 4C Openwrt bootloader 20dBm-30dBm TX Power mod


- Backup factory block

For this we use the Luci web interface to the device.
Go to System → Backup / Flash Firmware.
Under Save mtdblock contents select the factory mtdblock.
Click the SAVE MTDBLOCK button to download it.
The name of the file has a convention of <HOSTNAME>.<Partition name>.bin (e.g. bootloader.mtd0.bin)
Keep in mind that the factory block on each device is unique to that device and has to be treated as such.

- Edit The Factory Block

This is probably equivalent to brain surgery on a device LOL
Open the factory block file with a hex editor. We use GHex on Ubuntu.
Starting from address A0 is a row of values.
There are 14 of them.
On my 4C it is C0.
On the 4A 100M the value was 80 instead of C0 but the 14x pattern was still present.
See screenshot below


<img width="800" height="500" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/Screenshot_20231227_132624.jpg">

## Change those values to FF (`24`)

<img width="800" height="500" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/Screenshot_20231227_132730.jpg">



- Save the file under another name to show its the high power tweaked one e.g. 4C-GW.mtd2_hp.bin
Replace The factory Block
Copy the modified file to the /tmp directory on the device.
Insert the mtd-rw kernel module.
Override the old factory block.


## ssh into it

    ssh root@192.168.1.1

  U: root
  P: root

## AP is on 192.168.1.1

    scp bootloader.mtd0.bin root@192.168.1.1:/tmp
   
   or
    
    cd tmp
    
    wget http://path/bootloader.mtd0.bin

## cd to /tmp
   
    cd /tmp

## Insert the mtd_rw module 

Note: (You can potentially break the router but it is rare that's why you need the permission flag)
internet is required:

    opkg update && opkg install kmod-mtd-rw

    insmod mtd-rw.ko i_want_a_brick=1

## Substitute the name to match your file name
   
    mtd -e bootloader -r write /tmp/bootloader.mtd0.bin bootloader

## This will happen

.....
Unlocking bootloader
.....

Writing from /tmp/bootloader.mtd0.bin to bootloader ... 


<img width="300" height="500" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/IMG_20231227_135553.jpg">

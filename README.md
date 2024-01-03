#  Xiaom Mi 4C Openwrt factory mod increasing TX power to 20dBm-30dBm


- Backup factory block

For this we use the Luci web interface to the device.
Go to System → Backup / Flash Firmware.
Under Save mtdblock contents select the `factory` mtdblock.
Click the SAVE MTDBLOCK button to download it.
The name of the file has a convention of <HOSTNAME>.<Partition name>.bin (e.g. openwrt.mtd2.bin)
Keep in mind that the factory block on each device is unique to that device and has to be treated as such.

- Edit The Factory Block

This is probably equivalent to brain surgery on a device..
Open the factory block file with a hex editor. We use hex editor on Android.
Starting from address 000000A0 28 row of values.
There are 28 of them.
On my 4C it is start with A0.
On the 4A 100M the value was 80 instead of C0 but the 14x pattern was still present.

See screenshot below;


<img width="800" height="500" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/Screenshot_20231227_132624.jpg">

## Change those values to FF (`28`)

<img width="800" height="500" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/Screenshot_20231227_132730.jpg">



- Save the file under another name to show its the high power tweaked one e.g. openwrt.mtd2.bin
Replace The factory Block
Copy the modified file to the /tmp directory on the device.
Insert the mtd-rw kernel module.
Override the old factory block.


## ssh into it

    ssh root@192.168.1.1

  U: root
  P: root

## AP is on 192.168.1.1

    scp openwrt.mtd2.bin root@192.168.1.1:/tmp
   
   or
    
    cd tmp
    
    wget http://path/openwrt.mtd2.bin

## cd to /tmp
   
    cd /tmp

## Insert the mtd_rw module 

Note: (You can potentially break the router but it is rare that's why you need the permission flag)
internet is required:

    opkg update && opkg install kmod-mtd-rw

    insmod mtd-rw.ko i_want_a_brick=1

## Substitute the name to match your file name
   
    mtd -e factory -r write /tmp/openwrt.mtd2.bin factory

## This will happen

.....
Unlocking factory 
.....

Writing from /tmp/openwrt.mtd2.bin to factory... 


<img width="400" height="800" src="https://github.com/xiv3r/20dBm-30dBm-Xiaomi-Mi-4C-Router-Mod/blob/main/Main/IMG_20231227_135553.jpg">

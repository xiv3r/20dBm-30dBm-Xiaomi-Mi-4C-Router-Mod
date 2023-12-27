# 20dBm-30dBm TX Power for Xiaom Mi 4C openwrt bootloader mod


Backup factory block
For this we use the Luci web interface to the device.
Go to System → Backup / Flash Firmware.
Under Save mtdblock contents select the factory mtdblock.
Click the SAVE MTDBLOCK button to download it.
The name of the file has a convention of <HOSTNAME>.<Partition name>.bin (e.g. 4C-GW.mtd2.bin)
Keep in mind that the factory block on each device is unique to that device and has to be treated as such.

Edit The Factory Block
This is probably equivalent to brain surgery on a device LOL
Open the factory block file with a hex editor. We use GHex on Ubuntu.
Starting from address A0 is a row of values.
There are 14 of them.
On my 4C it is C0.
On the 4A 100M the value was 80 instead of C0 but the 14x pattern was still present.
See screenshot below


Change those values to FF.


Save the file under another name to show its the high power tweaked one e.g. 4C-GW.mtd2_hp.bin
Replace The factory Block
Copy the modified file to the /tmp directory on the device.
Insert the mtd-rw kernel module.
Override the old factory block.


### ssh into it

    ssh root@192.168.8.120

### AP is on 192.168.8.120

    scp 4C-GW.mtd2_hp.bin root@192.168.8.120:/tmp


### cd to /tmp
   
    cd /tmp

### Insert the mtd_rw module 

Note: (You can potentially break the router but it is rare that's why you need the permission flag)

    opkg update && opkg install kmod-mtd-rw

    insmod mtd-rw.ko i_want_a_brick=1

### Substitute the name to match your file name
   
    mtd write /tmp/4C-GW.mtd2_hp.bin factory

### This will happen

.....
Unlocking factory
.....

Writing from /tmp/4C-GW.mtd2_hp.bin to factory ... 

### Reboot the device

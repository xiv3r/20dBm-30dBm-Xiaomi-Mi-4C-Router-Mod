#!/bin/sh

insmod mtd-rw i_want_a_brick=1
echo "insmod done...!"
dd if=/dev/mtd2 of=/tmp/mtd2.bin
echo "Copying mtd2...!"
printf '\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff' |dd of=/tmp/mtd2.bin bs=1 seek=160 count=14 conv=notrunc
echo "Done modding mtd2...
echo "writing mtd2 to factory..."
mtd -r write /tmp/mtd2.bin factory
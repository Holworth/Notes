# Author: Huaqiang Wang
# Last Mod: 2018.10.18
# env.sh for OS lab of UCAS 

sudo apt-get install gdb-multiarch 
sudo dd if=/dev/zero of=disk bs=512 count=1M
# ./createimage –extended bootblock kernel
sudo dd if=image of=disk conv=notrunc
sudo chmod +x qemu/bin/qemu-system-mipsel

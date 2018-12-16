# Author: Huaqiang Wang
# Last Mod: 2018.10.18
# debug.sh for OS lab of UCAS 

# 设置虚拟盘
# 首次运行时执行, 其他情况下注释掉
# sudo apt-get install gdb-multiarch 
# chmod +x qemu/bin/qemu-system-mipsel
# sudo dd if=/dev/zero of=disk bs=512 count=1M

# shell ./createimage –extended bootblock kernel
make all
sudo dd if=image of=disk conv=notrunc

# 启动QEMU
sudo sh run_pmon.sh&
sleep 6

# 启动GDB
# sudo apt-get install gdb-multiarch 
gdb-multiarch
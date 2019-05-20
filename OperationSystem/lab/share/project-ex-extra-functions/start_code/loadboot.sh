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

# sudo apt-get install bridge-utils //安装 bridge-utils
# sudo apt-get install uml-utilities //安装 uml-utilities
sudo brctl addbr br0 //加入网桥
sudo tunctl -t tap0 -u stu //让用户 stu 可以控制 tap0
sudo brctl addif br0 tap0
sudo ifconfig tap0 up

sudo sh run_pmon.sh
# sleep 6

# 启动GDB
# sudo apt-get install gdb-multiarch 
# gdb-multiarch
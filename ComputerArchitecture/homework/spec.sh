# SPEC for ubuntu 16.04
# By AW

#!/bin/bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
sudo cat ./alisrc.16.04 >> /etc/apt/sources.list #修改
sudo apt update
sudo chmod +x -R ./*
# 1. required library
sudo apt-get install libc6-i386 
# 2. required compiler
sudo apt-get install g++ gfortran

sudo ./install.sh
sudo chmod +x -R ./*

ulimit -s unlimited
ulimit -c unlimited
. shrc
relocate

# 3. run test with different config files
runspec -c x86_64.O0.cfg -i ref -n 1 all -I -D
runspec -c x86_64.O2.cfg -i ref -n 1 all -I -D

# sudo ./RUNME.sh
sudo ./showresult.sh ./result/001.log > log1.log
sudo ./showresult.sh ./result/002.log > log2.log
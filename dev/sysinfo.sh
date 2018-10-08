#!/bin/sh
date
echo "[CPU]:"
grep "model name" /proc/cpuinfo | cut -f2 -d:
echo "[Memory]:"
grep MemTotal /proc/meminfo | cut -f2 -d:
echo "[Linux]:"
uname -a
echo "[MAC]:"
ifconfig |grep "HWaddr"|cut -d: -f2-
echo "[Compiler]:"
gcc --version |head -1
g++ --version |head -1
gfortran --version |head -1
echo "==================================="
echo "Checking develop environment."
echo "Last modified: 2018.10.14."
echo "==================================="


# 环境检查
echo "---------------环境检查---------------"

# MIPS cross compile tooltrain
echo "MIPS cross compile tooltrain"
mips-linux-gnu-gcc  -dumpmachine

# MIPS-LS232交叉编译工具
echo "LS232交叉编译工具"
mipsel-linux-gcc -v
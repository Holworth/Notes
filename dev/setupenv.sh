echo "Setting up develop environment."
echo "Last modified: 2018.9.8."

# 更新源
echo "更新源"

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
sudo cat alisrc.18.04 >> /etc/apt/sources.list #修改
sudo apt-get update #更新列表

# MIPS交叉编译工具链
echo "MIPS交叉编译工具链"

sudo apt-get -y install emdebian-archive-keyring 
sudo apt-get -y install linux-libc-dev-mips-cross 
sudo apt-get -y install libc6-mips-cross libc6-dev-mips-cross 
sudo apt-get -y install binutils-mips-linux-gnu gcc-4.4-mips-linux-gnu 
sudo apt-get -y install g++-4.4-mips-linux-gnu
sudo apt-get -y install gcc-mips-linux-gnu

# 环境检查

# MIPS cross compile tooltrain
mips-linux-gnu-gcc  -dumpmachine



 
clear
echo "==================================="
echo "Setting up develop environment."
echo "Last modified: 2018.10.14."
echo "==================================="

Checkenv()
{
    # 环境检查
    echo "---------------环境检查---------------"

    # MIPS cross compile tooltrain
    echo "----------------------------------------"
    echo "MIPS cross compile tooltrain"
    mips-linux-gnu-gcc  -dumpmachine

    # MIPS-LS232交叉编译工具
    echo "----------------------------------------"
    echo "LS232交叉编译工具"
    mipsel-linux-gcc -v
}

#/Checkenv
Checkenv

echo "---------------环境设置---------------"
# 更新源
if $# -eq 1; then
    echo "更新源"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
    sudo cat $1 >> /etc/apt/sources.list #修改
    sudo apt-get update #更新列表
fi

# 基本环境配置
echo "----------------------------------------"
echo "基本环境配置"
sudo  apt install curl

# MIPS交叉编译工具链
echo "----------------------------------------"
echo "MIPS交叉编译工具链"

sudo apt-get -y install emdebian-archive-keyring 
sudo apt-get -y install linux-libc-dev-mips-cross 
sudo apt-get -y install libc6-mips-cross libc6-dev-mips-cross 
sudo apt-get -y install binutils-mips-linux-gnu gcc-4.4-mips-linux-gnu 
sudo apt-get -y install g++-4.4-mips-linux-gnu
sudo apt-get -y install gcc-mips-linux-gnu

# MIPS-LS232交叉编译工具安装
echo "----------------------------------------"
echo "LS232交叉编译工具"

curl http://ftp.loongnix.org/toolchain/gcc/release/gcc-4.3-ls232.tar.gz --output gcc-4.3-ls232.tar.gz 
sudo tar -zxvf gcc-4.3-ls232.tar.gz -C /
echo -export PATH=/opt/gcc-4.3-ls232/bin:$PATH >> ~/.bashrc
export PATH=/opt/gcc-4.3-ls232/bin:$PATH
sudo apt-get install lsb-core 

#/Checkenv
Checkenv
#scp C:\Users\autum\download2\Anaconda2-5.3.0-Linux-x86_64.sh pubuser@124.16.70.252:/home/pubuser

# for root:
useradd -d /home/pubuser -m pubuser
passwd pubuser

useradd -d /home/wyp -m wyp
passwd wyp

cp /home/pubuser/Anaconda2-5.3.0-Linux-x86_64.sh /home/wyp
cd /home/wyp

chmod 770 /home/wyp/Anaconda2-5.3.0-Linux-x86_64.sh
chown wyp /home/wyp/Anaconda2-5.3.0-Linux-x86_64.sh

su wyp

# for users:

cd
# run ./Anaconda.....sh (在你的目录下运行Anaconda安装脚本)
./Anaconda2-5.3.0-Linux-x86_64.sh

source .bash_profile

conda info --envs
conda create -n tensorflow --clone root
source activate tensorflow
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda install tensorflow-gpu -y

conda create -n tensorflow3 python=3 -y
source .bash_profile
source activate tensorflow3
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda install numpy -y
conda install scipy -y
conda install pandas -y
conda install tensorflow-gpu -y

conda info --envs


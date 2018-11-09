#scp C:\Users\autum\download2\Anaconda2-5.3.0-Linux-x86_64.sh pubuser@124.16.70.252:/home/pubuser


useradd -d /home/pubuser -m pubuser
passwd pubuser

su pubuser

conda info --envs
conda create -n tensorflow --clone root
source activate tensorflow
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda install tensorflow-gpu -y

conda create -n tensorflow3 python=3 -y
source activate tensorflow3
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
conda install numpy -y
conda install scipy -y
conda install pandas -y
conda install tensorflow-gpu -y

conda info --envs

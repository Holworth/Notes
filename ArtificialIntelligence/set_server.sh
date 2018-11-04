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

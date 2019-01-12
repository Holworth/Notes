
<!-- # useradd -d /home/zw -m zw -->
<!-- # passwd zw -->
<!-- # zyx -->

人工智能课程服务器登陆凭据
======================

* 蔡昕


# 1. 登录凭据

服务器ip|用户名|密码
-|-|-
124.16.70.64|cx|fuckai

# 2. 使用说明

可以使用以下语句来连接服务器: `ssh cx@124.16.70.64`

服务器的默认软件环境如下:

使用`source activate tensorflow`来激活python2.7环境

使用`source activate tensorflow3`来激活python3.6环境

# 3. 重置环境

服务器上的环境配置使用以下脚本:

```shell

# run ./Anaconda.....sh (在你的目录下运行Anaconda安装脚本)

source .bash_profile

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


```

---

有任何问题请联系: wanghuaqiang16@mails.ucas.ac.cn

Suffer well (٩( 'ω' )و ).
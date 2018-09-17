if [$# -ne 1] then
echo "Need parameter: srclist.\n"
exit 1
fi

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
sudo cat $1 >> /etc/apt/sources.list #修改
sudo apt-get update #更新列表
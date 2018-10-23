# DEBUG 环境使用说明

## 0. 将所有文件复制到与Makefile平级的目录下

## 1. 如果之前没有配置过环境:

```
sudo chmod +x ./env.sh
sudo ./env.sh
sudo chmod +x ./loadboot.sh
```

## 2. 每次debug时运行:

```
./loadboot.sh
# 切换终端 (ctrl+alt+F1/F2/F3)
# 在另一个终端执行
gdb-multiarch

# 已经可以用了
# 如果还不会用:

# 回车
# 切换终端 (ctrl+alt+1/2/3) 返回模拟器
# loadboot
```

***

Huaqiang Wang (c) 2018
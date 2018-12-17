sudo brctl addbr br0 //加入网桥
sudo tunctl -t tap0 -u stu //让用户 stu 可以控制 tap0
sudo brctl addif br0 tap0
sudo ifconfig tap0 up
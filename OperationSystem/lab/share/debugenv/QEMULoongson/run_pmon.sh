
#SERIAL=11 SIMPLEVGA=800x600-16 ./qemu/bin/qemu-system-mipsel -M ls1c -vnc 127.0.0.1:0 -bios ./bios/gzrom.bin -gdb tcp::50010 -m 32 -usb -device usb-kbd,bus=usb-bus.1 -device usb-mouse,bus=usb-bus.1 -drive file=disk,id=a,if=none -device usb-storage,bus=usb-bus.1,drive=a  -serial stdio  "$@"


#./qemu/bin/qemu-system-mipsel -M ls1c -vnc 127.0.0.1:0 -bios ./bios/pmon_openloongson.bin -gdb tcp::50010 -m 32 -usb -usbdevice tablet -usbdevice host:14cd:1212 -serial stdio  "$@"


#./qemu/bin/qemu-system-mipsel -M ls1c -vnc 127.0.0.1:0 -bios ./bios/pmon_openloongson.bin -kernel ./bios/gzram -gdb tcp::50010 -m 32 -usb -drive file=disk,id=a,if=none -device usb-storage,bus=usb-bus.1,drive=a  -serial stdio  "$@"

#SERIAL=2 ./qemu/bin/qemu-system-mipsel -M ls1c -vnc 127.0.0.1:0 -kernel ./bios/gzram -gdb tcp::50010 -m 32 -usb -drive file=disk,id=a,if=none -device usb-storage,bus=usb-bus.1,drive=a  -serial stdio  "$@"

SERIAL=2 ./qemu/bin/qemu-system-mipsel -M ls1c -vnc 127.0.0.1:0 -kernel ./bios/gzram -gdb tcp::50010 -m 32 -usb -drive file=disk,id=a,if=none -device usb-storage,bus=usb-bus.1,drive=a  -serial stdio  "$@"

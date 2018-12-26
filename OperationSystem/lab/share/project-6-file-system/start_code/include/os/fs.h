// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                     File System Header
// ----------------------------------------------------------------
//              Copyright (C) 2018 Wang Huaqiang
//             email : wanghuaqiang16@mails.ucas.ac.cn
// ----------------------------------------------------------------
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// -----------------------------------------------------------------

#ifndef INCLUDE_FS_H_
#define INCLUDE_FS_H_

#include "type.h"

#define FILETYPE_FILE 0
#define FILETYPE_DIR 1

#define ACCESS_R 0
#define ACCESS_W 1
#define ACCESS_RW 2

#define BITMAP(bitmap, num) (bitmap & (1 << num))

unsigned char file_buffer[16][4096];       //16*4KB=64KB
unsigned char file_write_buffer[16][4096]; //16*4KB=64KB

// 目录操作
// 函数名 shell 命令 说明
int mkfs(uint32_t size);  // mkfs 初始化文件系统
int mkdir(char *name);    // mkdir 创建目录
int rmdir(char *name);    // rmdir 删除目录
int read_dir();           // ls 打印目录目录的内容
int fs_info();            // statfs 打印文件系统信息，包括数据块的使用情况等
int enter_fs(char *path); // cd 进入目录 (递归实现?)

// 文件操作
// 函数名 shell 命令 说明
int mknod(char *name);                   // touch 建立一个文件
int cat(char *name);                     // cat 将文件的内容打印到屏幕
int open(char *name, int access);        // 打开一个文件
int read(int fd, char *buff, int size);  // 读一个文件
int write(int fd, char *buff, int size); // 写一个文件
int close(int fd);                       // 关闭一个文件

int find(char *path, char *name);
int rename(char *old_name, char *new_name);
int hardlink(char *target, char *linkname);
int softlink(char *target, char *linkname);

//TODO SYNC AND BUFFER

// 目录操作
// 函数名 shell 命令 说明
int cmd_mkfs();   // mkfs 初始化文件系统
int cmd_mkdir();  // mkdir 创建目录
int cmd_rmdir();  // rmdir 删除目录
int cmd_ls();     // ls 打印目录目录的内容
int cmd_statfs(); // statfs 打印文件系统信息，包括数据块的使用情况等
int cmd_cd();     // cd 进入目录
int cmd_find();
int cmd_rename();
int cmd_ln();

// 文件操作
// 函数名 shell 命令 说明
int cmd_touch(); // touch 建立一个文件
int cmd_cat();   // cat 将文件的内容打印到屏幕

typedef struct virtual_file_system
{
    int (*mkfs)(uint32_t size);  // mkfs 初始化文件系统
    int (*mkdir)(char *name);    // mkdir 创建目录
    int (*rmdir)(char *name);    // rmdir 删除目录
    int (*read_dir)();           // ls 打印目录目录的内容
    int (*fs_info)();            // statfs 打印文件系统信息，包括数据块的使用情况等
    int (*enter_fs)(char *path); // cd 进入目录 (递归实现?)

    // 文件操作
    // 函数名 shell 命令 说明
    int (*mknod)(char *name);                   // touch 建立一个文件
    int (*cat)(char *name);                     // cat 将文件的内容打印到屏幕
    int (*open)(char *name, int access);        // 打开一个文件
    int (*read)(int fd, char *buff, int size);  // 读一个文件
    int (*write)(int fd, char *buff, int size); // 写一个文件
    int (*close)(int fd);                       // 关闭一个文件

    int (*find)(char *path, char *name);
    int (*rename)(char *old_name, char *new_name);
    int (*hardlink)(char *target, char *linkname);
    int (*softlink)(char *target, char *linkname);
}virtual_file_system_t;

virtual_file_system_t* global_fs;

// int register_vfs()
// {

// }

//TODO deal with absolute/relative path

#endif
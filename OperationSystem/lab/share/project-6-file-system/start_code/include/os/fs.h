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
#define FILETYPE_SL 2
#define FILETYPE_HL 3

#define ACCESS_R 0
#define ACCESS_W 1
#define ACCESS_RW 2

#define DIR_DEPTH_MAX 12
#define FDESC_NUM 16

#define BITMAP(bitmap, num) (bitmap & (1 << num))
#define BITMAP_SET0(bitmap, num) (bitmap=(bitmap & (0xffffffff - (1 << num))))
#define BITMAP_SET1(bitmap, num) (bitmap=(bitmap | (1 << num)))

#define ALIGN_512(x) (x-x%512)

#define O_NONE 0x0
#define O_RD   0x1 //0b...0001
#define O_WR   0x2 //0b...0010
#define O_RDWR 0x3 //0b...0011

#define diskaddr_t uint32_t


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
// int cmd_mkfs();   // mkfs 初始化文件系统
// int cmd_mkdir();  // mkdir 创建目录
// int cmd_rmdir();  // rmdir 删除目录
// int cmd_ls();     // ls 打印目录目录的内容
// int cmd_statfs(); // statfs 打印文件系统信息，包括数据块的使用情况等
// int cmd_cd();     // cd 进入目录
// int cmd_find();
// int cmd_rename();
// int cmd_ln();

// // 文件操作
// // 函数名 shell 命令 说明
// int cmd_touch(); // touch 建立一个文件
// int cmd_cat();   // cat 将文件的内容打印到屏幕

int mkfs(uint32_t size);
int mkdir(char *name);
int rmdir(char *name);
int read_dir();
int fs_info();
int enter_fs(char *path);
int mknod(char *name);
int rm(char *name);
int cat(char *name);
int open(char *name, int access); // 打开一个文件;
int read(int fd, char *buff, int size);
int write(int fd, char *buff, int size);
int seek(int fd, uint32_t offset);
int close(int fd);
int find(char *path, char *name);
int rename(char *old_name, char *new_name);
int hardlink(char *target, char *linkname);
int softlink(char *target, char *linkname);
void cmd_ln(char *target, char *linkname, char *para);

char *filetype(char type);

typedef struct file_system
{
    int (*mkfs)(uint32_t size);  // mkfs 初始化文件系统
    int (*mnt)();                // mnt  挂载文件系统
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
    int (*rm)(char *name);
} file_system_t;

typedef struct file_descriptor
{
    // void* buffer;
    diskaddr_t inode;
    diskaddr_t diskbase;
    uint32_t pos;
    // uint32_t size;
    uint32_t mode_mask; //mask from file
    uint32_t access;    //r/w/rw
    int valid;

    // inode_sd_t inode_buffer;

} fdesc_t;

unsigned char file_buffer[4096];  //4KB
unsigned char dir_buffer[4096];   //4KB
unsigned char mkdir_buffer[4096]; //4KB
// unsigned char file_read_buffer[16][4096];  //16*4KB=64KB
// unsigned char file_write_buffer[16][4096]; //16*4KB=64KB

extern char filetype_file_str[];
extern char filetype_dir_str[];
extern char filetype_sl_str[];
extern char filetype_hl_str[];

file_system_t *global_fs;

diskaddr_t current_dir;
diskaddr_t root_dir;

char current_dir_name[DIR_DEPTH_MAX][32];
int current_dir_level;

fdesc_t fdesc[FDESC_NUM];
//TODO deal with absolute/relative path

int sdread_not_aligned(char* buff, uint32_t position, uint32_t size);
int sdwrite_not_aligned(char* buff, uint32_t position, uint32_t size);

#endif
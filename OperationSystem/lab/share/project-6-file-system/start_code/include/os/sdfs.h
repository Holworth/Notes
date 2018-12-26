// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                    SD Card File System
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

// SD card file system for OS seminar
// This filesystem looks like this:
// 
// --------------------------------------------------
// | Superblock   | Inode Bitmap | Inode |  Blocks  |
// | Block Bitmap | 1 Block 4KB  |  1MB  |  Others  |
// --------------------------------------------------


#include "fs.h"
#ifndef INCLUDE_SDFS_H_
#define INCLUDE_SDFS_H_

#define SUPER_BLOCK_HEAD_MAGIC 0xABCD1111
#define BLOCKSIZE 4096
#define FILEALIGN BLOCKSIZE
#define FSSTART 0x‭20000000‬ //TODO

typedef struct inode_sd
{
    char type;
    char addr_level;
    char hardlink_cnt;
    char bit_mask;
    //1
    uint32_t owner;
    uint32_t group;
    uint32_t mode_mask;
    uint32_t create_timestamp;
    uint32_t access_timestamp;
    uint32_t modify_timestamp;
    //7

    uint32_t size;
    //8

    void *blocks[16];
    //24

    struct inode_sd* ext_inode1;
    struct inode_sd* ext_inode2;
    struct inode_sd* ext_inode3;
    //27

    uint32_t allign[5];
    //32
} inode_sd_t; //size: 32*sizeof(int) -> 128Byte

typedef struct superblock_head_sd
{
    uint32_t superblock_head_magic;
    uint32_t fs_size;
    uint32_t fs_start;
    uint32_t fs_end;

    uint32_t block_map_size;
    void *block_map_start;

    uint32_t inode_map_size;
    void *inode_map_start;

    uint32_t inode_size;
    uint32_t inode_num;
    void *inode_start;

    uint32_t *data_size;
    void *data_start;
    // int      is_backup;
} superblock_head_sd_t;

typedef struct partition_table_sd
{
    int partition_num;
    struct superblock_head_sd *sblock_list[4];
} partition_table_sd_t;

typedef struct dentry_sd
{
    char name[24];
    uint32_t type;
    inode_sd_t *inode;
} dentry_t; //32Byte

typedef struct directory_sd
{
    uint32_t hardlink_num;
    uint32_t file_num;
    dentry_t dentry[16];
    char file_type[16];
} dir_t;

typedef struct file_descriptor_sd
{
    void* buffer;
    uint32_t pos;
    uint32_t size;
    uint32_t mode_mask;
    uint32_t access;//r/w/rw
    //reserved
}fdesc_t;

int mkfs_sd(uint32_t size);  // mkfs 初始化文件系统
int mkdir_sd(char *name);    // mkdir 创建目录
int rmdir_sd(char *name);    // rmdir 删除目录
int read_dir_sd();           // ls 打印目录目录的内容
int fs_info_sd();            // statfs 打印文件系统信息，包括数据块的使用情况等
int enter_fs_sd(char *path); // cd 进入目录 (递归实现?)

// 文件操作
// 函数名 shell 命令 说明
int mknod_sd(char *name);                   // touch 建立一个文件
int cat_sd(char *name);                     // cat 将文件的内容打印到屏幕
int open_sd(char *name, int access);        // 打开一个文件
int read_sd(int fd, char *buff, int size);  // 读一个文件
int write_sd(int fd, char *buff, int size); // 写一个文件
int close_sd(int fd);                       // 关闭一个文件

int find_sd(char *path, char *name);
int rename_sd(char *old_name, char *new_name);
int hardlink_sd(char *target, char *linkname);
int softlink_sd(char *target, char *linkname);

virtual_file_system_t sdfs;

// mkfs_sd
// mkdir_sd
// rmdir_sd
// read_dir_sd
// fs_info_sd
// enter_fs_sd
// mknod_sd
// cat_sd
// open_sd
// read_sd
// write_sd
// close_sd
// find_sd
// rename_sd
// hardlink_sd
// softlink_sd

#endif
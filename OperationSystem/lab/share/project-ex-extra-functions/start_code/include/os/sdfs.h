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
// Max FS size: 2GB
// Min FS size: 2MB
// -----------------------------------------------------------------------
// | Superblock | Block Bitmap | Inode Bitmap | Inode         |  Blocks  |
// | 1 Block    | 8 Block 32KB | 1 Block 4KB  | 256 Block 1MB |  Others  |
// -----------------------------------------------------------------------

#include "fs.h"
#ifndef INCLUDE_SDFS_H_
#define INCLUDE_SDFS_H_

#define SUPER_BLOCK_HEAD_MAGIC_SD 0xABCD1111
#define BLOCKSIZE_SD 4096
#define FILEALIGN_SD BLOCKSIZE
#define FSSTART_SD 0x10000000

extern char block_bitmap_buffer[32*1024];
extern char inode_bitmap_buffer[4*1024];

typedef struct inode_sd
{
    char type;
    char hardlink_cnt;
    char res1; //not used
    char res2; //not used
    //1 0x0
    uint32_t owner;
    uint32_t group;
    uint32_t mode_mask;
    uint32_t create_timestamp;
    uint32_t access_timestamp;
    uint32_t modify_timestamp;
    //7

    uint32_t size;//0x1c
    //8 

    diskaddr_t blocks[16];
    //24

    diskaddr_t ext_inode1;
    diskaddr_t ext_inode2;
    diskaddr_t ext_inode3;
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
    uint32_t block_map_start;

    uint32_t inode_map_size;
    uint32_t inode_map_start;

    uint32_t inode_size;
    uint32_t inode_num;
    uint32_t inode_start;

    uint32_t data_size;
    uint32_t data_start;

    // inode_sd_t* root_node;
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
    diskaddr_t inode; //==0 means not used
    int valid;
} dentry_t; //32Byte

#define DIR_FILE_MAX 32

typedef struct directory_sd
{
    // uint32_t hardlink_num;
    uint32_t file_num;
    dentry_t dentry[DIR_FILE_MAX];
} dir_t;

int mkfs_sd(uint32_t size);  // mkfs 初始化文件系统
int mnt_sd();                // mnt 挂载文件系统
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
int rm_sd(char *name);

file_system_t sdfs;
struct superblock_head_sd head_buffer;
superblock_head_sd_t superblock;

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
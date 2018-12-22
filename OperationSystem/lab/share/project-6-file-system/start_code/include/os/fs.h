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

#define SUPER_BLOCK_HEAD_MAGIC 0xABCD1111
#define BLOCKSIZE 4096
#define FILEALIGN BLOCKSIZE
#define FSSTART 0x‭20000000‬ //TODO

#define FILETYPE_FILE 0
#define FILETYPE_DIR 1

#define ACCESS_R 0
#define ACCESS_W 1
#define ACCESS_RW 2

#define BITMAP(bitmap, num) (bitmap&(1<<num))

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
int mknod(char *name);                              // touch 建立一个文件
int cat(char *name);                                // cat 将文件的内容打印到屏幕
int open(char* name, int access);                               // 打开一个文件
int read(int fd, char* buff, int size);                               // 读一个文件
int write(int fd, char* buff, int size); // 写一个文件
int close(int fd);                              // 关闭一个文件

int find(char* path, char* name);
int rename(char* old_name, char* new_name);
int hardlink(char* target, char* linkname);
int softlink(char* target, char* linkname);

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

typedef struct ext_inode
{
    uint32_t bit_mask;
    void *blocks[8];


}ext_inode_t;

typedef struct inode
{
    char type;
    char addr_level;
    char res1;
    char res2;
    uint32_t owner;
    uint32_t mode_mask;
    uint32_t mod_timestamp;
    //4

    uint32_t size;
    uint32_t hlink_cnt;
    uint32_t bit_mask;
    //7

    void *blocks[8];
    //15

    ext_inode_t* ext_inode;
    //16
} inode_t; //size: 16*sizeof(int)

typedef struct superblock_head
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
} superblock_head_t;

typedef struct partition_table
{
    int partition_num;
    struct superblock_head *sblock_list[4];
} partition_table_t;

typedef struct dentry
{
    char name[24];
    uint32_t type;
    inode_t *inode;
} dentry_t; //32Byte

typedef struct directory
{
    uint32_t hlink_num;
    uint32_t file_num;
    dentry_t dentry[16];
    char file_type[16];
} dir_t;

typedef struct file_descriptor
{
    void* buffer;
    uint32_t pos;
    uint32_t size;
    uint32_t mode_mask;
    uint32_t access;//r/w/rw
    //reserved
}fdesc_t;

//TODO deal with absolute/relative path

#endif
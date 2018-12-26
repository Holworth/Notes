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

#include "fs.h"
#include "sdfs.h"
#include "stdio.h"
#include "string.h"

// SD card file system for OS seminar
// This filesystem looks like this:
// Max FS size: 2GB
// Min FS size: 2MB
// ------------------------------------------------------------------------
// | Superblock | Block Bitmap  | Inode Bitmap | Inode         |  Blocks  |
// | 1 Block    | 16 Block 64KB | 1 Block 4KB  | 256 Block 1MB |  Others  |
// ------------------------------------------------------------------------

// unsigned char file_buffer[4096];       //4KB

static int write_buffer(uint32_t sd_position)
{
    return sdwrite(&file_buffer, sd_position, BLOCKSIZE_SD);
}

static int write_dir()
{
    return sdwrite(&dir_buffer, current_dir_block, BLOCKSIZE_SD);
}

static int sync_dir()
{
    return sdwrite(&dir_buffer, current_dir_block, BLOCKSIZE_SD);
}

static int sync_block_bitmap()
{
    panic("TBD");
    return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

static int sync_block_bitmap_all()
{
    panic("TBD");
    return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

static int sync_inode_bitmap()
{
    panic("TBD");
    return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

static int sync_sblock()
{
    return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

static int sync_file();

static int insert_sys_dir(inode_sd_t *self, inode_sd_t *parent)
{
    // os_assert(((dir_t*)dir_buffer)->file_num<DIR_FILE_MAX);
    os_assert(((dir_t *)mkdir_buffer)->file_num == 0);
    ((dir_t *)mkdir_buffer)->dentry[0].name[0] = '.';
    ((dir_t *)mkdir_buffer)->dentry[0].name[1] = '\0';
    ((dir_t *)mkdir_buffer)->dentry[1].name[0] = '.';
    ((dir_t *)mkdir_buffer)->dentry[1].name[1] = '.';
    ((dir_t *)mkdir_buffer)->dentry[1].name[2] = '\0';
    ((dir_t *)mkdir_buffer)->dentry[0].inode = (inode_sd_t *)self;
    ((dir_t *)mkdir_buffer)->dentry[1].inode = (inode_sd_t *)parent;
    ((dir_t *)mkdir_buffer)->dentry[0].valid = 1;
    ((dir_t *)mkdir_buffer)->dentry[1].valid = 1;
    ((dir_t *)mkdir_buffer)->file_num = 2;
    return 0;
}

static int set_block_bitmap(uint32_t block_num)
{
    panic("TBD");
    uint32_t disk_point = FSSTART_SD;

    int i;
    for (i = 0; i < BLOCKSIZE_SD; i++)
    {
        file_buffer[i] = 0xff;
    }
    for (i = 0; i < 16; i++)
    {
        disk_point += BLOCKSIZE_SD;
        write_buffer(disk_point);
    }

    int block_left = (int)block_num;
    uint32_t bufferp = (uint32_t)&file_buffer;
    disk_point = FSSTART_SD + BLOCKSIZE_SD;
    while (block_left >= 8)
    {
        *(char *)bufferp = 0;
        block_left -= 8;
        bufferp += 1;
        if (bufferp == BLOCKSIZE_SD)
        {
            bufferp = 0;
            write_buffer(disk_point);
            disk_point += BLOCKSIZE_SD;
            int i;
            for (i = 0; i < BLOCKSIZE_SD; i++)
            {
                file_buffer[i] = 0xff;
            }
        }
    }
    write_buffer(disk_point); //the last 0-6 blocks not alloced
    return 0;
}

static int set_superblock(int size)
{
    uint32_t disk_point = FSSTART_SD;
    superblock.superblock_head_magic = SUPER_BLOCK_HEAD_MAGIC_SD;//size: B
    superblock.fs_size = size << 12;
    superblock.fs_start = FSSTART_SD;
    superblock.fs_end = FSSTART_SD + size << 12;
    superblock.block_map_size = 16 * BLOCKSIZE_SD;
    superblock.block_map_start = FSSTART_SD + BLOCKSIZE_SD;
    superblock.inode_map_size = 1 * BLOCKSIZE_SD;
    superblock.inode_map_start = FSSTART_SD + 17 * BLOCKSIZE_SD;
    superblock.inode_num = 1;
    superblock.inode_size = 1 * sizeof(inode_sd_t);
    superblock.inode_start = FSSTART_SD + 18 * BLOCKSIZE_SD;
    superblock.data_size = BLOCKSIZE_SD;
    superblock.data_start = FSSTART_SD + (18 + 256) * BLOCKSIZE_SD;
    // sblock->root_node=FSSTART_SD+(18+256)*BLOCKSIZE_SD;

    // write_buffer(disk_point);
    return 0;
}

static int set_inode_bitmap()
{
    panic("TBD");

    int i;
    for (i = 0; i < BLOCKSIZE_SD; i++)
    {
        file_buffer[i] = 0x00;
    }
    file_buffer[0] = 0x1;
    write_buffer(superblock.inode_map_start);
}

static int set_root_inode()
{
    panic("TBD");

    inode_sd_t *root_node = (inode_sd_t *)&file_buffer;
    root_node->type = FILETYPE_DIR;
    root_node->hardlink_cnt = 0;
    root_node->owner = 0;
    root_node->group = 0;
    root_node->mode_mask = 777;
    root_node->create_timestamp = 0;
    root_node->access_timestamp = 0;
    root_node->modify_timestamp = 0;
    root_node->size = BLOCKSIZE_SD;
    root_node->blocks[0] = superblock.data_start;
    char tmp = 1;
    sdwrite(&tmp, superblock.block_map_start, 1);
}

static int set_root_dir()
{
    panic("TBD");

}

static int load_superblock();//return 1 if load_sblock failed
static int load_block_bitmap();
static int load_inode_bitmap();
static int load_root_dir();

static uint32_t alloc_inode()
{
}

uint32_t block_alloc_cnt;

static uint32_t alloc_block()
{
}

static uint32_t free_inode()
{
}

static uint32_t free_block()
{
}

static int path_add(char* name)
{
    os_assert(current_dir_level<DIR_DEPTH_MAX);
    current_dir_level++;
    strcpy(current_dir_name[current_dir_level], name);
    return 0;
}

static int path_leave()
{
    os_assert(current_dir_level>0);
    current_dir_level--;
}

static int path_reset()
{
    current_dir_level = 0;
    current_dir_name[0][0] = '\0';
    return 0;
}


int mkfs_sd(uint32_t size) //size: Block
{
    //suggest: use 1<<19 (2GB) as fs size
    uint32_t block_num = (size - 1 - 16 - 1 - 256);
    uint32_t disk_point = FSSTART_SD;

    //set superblock
    set_superblock(size);
    sync_sblock();

    //set block bitmap
    //set buffer to 1
    set_block_bitmap(block_num);
    sync_block_bitmap_all();

    //set inode bitmap
    set_inode_bitmap();
    sync_inode_bitmap();

    //set root inode
    set_root_inode();

    //set root dir
    set_root_dir();

    //set global points
    current_dir_level = 0;
    current_dir_name[0][0] = '\0';
    current_dir = (void *)superblock.inode_start;
    root_dir = (void *)superblock.inode_start;
    current_dir_block = (void *)superblock.data_start;
    root_dir_block = (void *)superblock.data_start;

    return 0;
}
// mkfs 初始化文件系统

int mnt_sd()
// mnt 挂载文件系统
// return 0 if succeed
// reutrn 1 if failed
{
    if(load_superblock())//load_sblock failed
    {
        return 1;
    }

    // load_superblock();//load_sblock failed
    load_block_bitmap();
    load_inode_bitmap();
    load_root_dir();

    return 0;
    //TODO
}

int mkdir_sd(char *name)
// mkdir 创建目录
{
    //check if the name is valid
    if (!strcmp(name, "."))
    {
        printf("You can not make dir '.'\n");
        return 1;
    }
    if (!strcmp(name, ".."))
    {
        printf("You can not make dir '..'\n");
        return 2;
    }
    if (!strcmp(name, ""))
    {
        printf("You can not make dir with empty name.\n");
        return 3;
    }
    int i;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[i].name))
            {
                printf("Dir %s already exists.\n", name);
                return 4;
            }
        }
    }

    //get block position on disk
    uint32_t block = alloc_block();
    if (!block)
        return 5;
    //get inode position on disk
    uint32_t inode = alloc_inode();
    if (!inode)
        return 6;
    //setup sys dir
    memset(&dir_buffer, 0, BLOCKSIZE_SD);
    ((dir_t *)mkdir_buffer)->file_num = 0;
    insert_sys_dir((inode_sd_t *)inode, (inode_sd_t *)current_dir);
    printf("Made dir %s.\n", name);

    return 0;
}

static int rmdir_by_inode()
{
    //TODO
}

int rmdir_sd(char *name)
// rmdir 删除目录
{
    if (!strcmp(name, "."))
    {
        printf("You can not rm '.'\n");
        return 1;
    }
    if (!strcmp(name, ".."))
    {
        printf("You can not rm '..'\n");
        return 2;
    }
    os_assert(((dir_t *)mkdir_buffer)->file_num >= 2);
    if (((dir_t *)mkdir_buffer)->file_num > 2)
    {
        printf("[WARNING] rm a nonempty forder.\n");
    }
    int i;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[i].name))
            {
                ((dir_t *)dir_buffer)->dentry[i].valid = 0;
                ((dir_t *)dir_buffer)->file_num -= 1;
                sync_dir();
                printf("Deleted dir %s.\n", name);
                return 0; //succeed
            }
        }
    }
    printf("RM dir failed, for dir %s does not exist.\n", name);
    return 3; //not found
}

int read_dir_sd()
// ls 打印目录目录的内容
{
    inode_sd_t inode_buf;

    int i;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            sdread(&inode_buf, ((dir_t *)dir_buffer)->dentry[i].inode, sizeof(inode_sd_t));
            inode_sd_t *node = &inode_buf;
            printf("%s::  %d  %s  %xB\n",
                   node->mode_mask,
                   filetype(node->type),
                   node->size);
        }
    }
}

int fs_info_sd()
// statfs 打印文件系统信息，包括数据块的使用情况等
{
}

int enter_fs_sd(char *path) 
// cd 进入目录 (递归实现?)
{
    diskaddr temp_inode;
    diskaddr temp_block;

    current_dir=temp_inode;
    current_dir_block=temp_block;
    
    return 0;

failed:
    return 1;
} 

// 文件操作
// 函数名 shell 命令 说明
int mknod_sd(char *name) {}                   // touch 建立一个文件
int cat_sd(char *name) {}                     // cat 将文件的内容打印到屏幕
int open_sd(char *name, int access) {}        // 打开一个文件
int read_sd(int fd, char *buff, int size) {}  // 读一个文件
int write_sd(int fd, char *buff, int size) {} // 写一个文件
int close_sd(int fd) {}                       // 关闭一个文件

int find_sd(char *path, char *name) {}
int rename_sd(char *old_name, char *new_name) {}
int hardlink_sd(char *target, char *linkname) {}
int softlink_sd(char *target, char *linkname) {}

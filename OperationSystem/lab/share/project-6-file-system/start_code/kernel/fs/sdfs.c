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

char block_bitmap_buffer[32 * 1024];
char inode_bitmap_buffer[4 * 1024];

char parsed_dir_name[10][20];
int dir_depth;
int absolute_path;
int name_pointer;
char *current_path_string[128];

static diskaddr_t inode_to_block(diskaddr_t inode_addr)
{
    //load inode
    char buff[512];
    uint32_t offset = inode_addr % 512;
    sdread(&buff, inode_addr - offset, 512);
    return (*(inode_sd_t *)(&buff[offset]))->blocks[0];
}

static int load_block_bitmap()
{
    os_assert(superblock.superblock_head_magic == SUPER_BLOCK_HEAD_MAGIC_SD);
    return sdread(&block_bitmap_buffer, superblock.block_map_start, sizeof(block_bitmap_buffer));
}

static int load_inode_bitmap()
{
    os_assert(superblock.superblock_head_magic == SUPER_BLOCK_HEAD_MAGIC_SD);
    return sdread(&inode_bitmap_buffer, superblock.inode_map_start, sizeof(inode_bitmap_buffer));
}

static int write_buffer(uint32_t sd_position)
{
    return sdwrite(&file_buffer, sd_position, BLOCKSIZE_SD);
}

static int write_dir(diskaddr_t dir_addr)
{
    return sdwrite(&dir_buffer, dir_addr, BLOCKSIZE_SD);
}

static int write_inode(diskaddr_t inode_addr, inode_sd_t *buffer)
{
    char buff[512];
    int offset = inode_addr % 512;
    sdread(buff, inode_addr - offset, 512);
    int i;
    for (i = 0; i < sizeof(inode_sd_t); i++)
    {
        buff[offset + i] = buffer[i];
    }
    return sdwrite(buff, inode_addr - offset, 512);
}

static int sync_dir()
{
    return sdwrite(&dir_buffer, inode_to_block(current_dir), BLOCKSIZE_SD);
}

static int sync_block_bitmap_all()
{
    // panic("TBD");
    return sdwrite(&block_bitmap_buffer, superblock.block_map_start, sizeof(block_bitmap_buffer));
}

static int sync_block_bitmap()
{
    panic("TBD");
    sync_block_bitmap_all();
    // return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

// static int load_block_bitmap()
// {
//     return sdread(&block_bitmap_buffer, superblock.block_map_start, sizeof(block_bitmap_buffer));
// }

// static int load_inode_bitmap()
// {
//     return sdread(&inode_bitmap_buffer, superblock.inode_map_start, sizeof(inode_bitmap_buffer));
// }

static int sync_inode_bitmap()
{
    return sdwrite(&inode_bitmap_buffer, superblock.inode_map_start, sizeof(inode_bitmap_buffer));
}

static int sync_sblock()
{
    return sdwrite(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
}

static int sync_file()
{
    panic("TBD sync_file");
}

static diskaddr_t locate_block_addr(diskaddr_t inode_addr, uint32_t offset)
{
    panic("TBD");
    //load inode
    inode_sd_t buff;
    sdread(&buff, inode_addr, sizeof(inode_sd_t));
    return buff.blocks[0];
}

static int insert_sys_dir(diskaddr_t self, diskaddr_t parent)
{
    // os_assert(((dir_t*)dir_buffer)->file_num<DIR_FILE_MAX);
    os_assert(((dir_t *)mkdir_buffer)->file_num == 0);
    ((dir_t *)mkdir_buffer)->dentry[0].name[0] = '.';
    ((dir_t *)mkdir_buffer)->dentry[0].name[1] = '\0';
    ((dir_t *)mkdir_buffer)->dentry[1].name[0] = '.';
    ((dir_t *)mkdir_buffer)->dentry[1].name[1] = '.';
    ((dir_t *)mkdir_buffer)->dentry[1].name[2] = '\0';
    ((dir_t *)mkdir_buffer)->dentry[0].inode = self;
    ((dir_t *)mkdir_buffer)->dentry[1].inode = parent;
    ((dir_t *)mkdir_buffer)->dentry[0].valid = 1;
    ((dir_t *)mkdir_buffer)->dentry[1].valid = 1;
    ((dir_t *)mkdir_buffer)->file_num = 2;
    return 0;
}

static int set_block_bitmap(uint32_t block_num)
//This func init the blockmap in memory and then sync it to the sdcard.
{
    int i;
    for (i = 0; i < sizeof(block_bitmap_buffer); i++)
    {
        block_bitmap_buffer[i] = 1; //set to used
    }

    for (i = 0; block_num > 0; i++)
    {
        if (block_num >= 8)
        {
            block_bitmap_buffer[i] = 0; //set to unused
            block_num -= 8;
        }
        else
        {
            block_bitmap_buffer[i] = 0xff << block_num; //set to unused
            block_num = 0;
        }
    }

    sync_block_bitmap_all();
    return 0;
}

static int set_superblock(int size)
{
    uint32_t disk_point = FSSTART_SD;
    superblock.superblock_head_magic = SUPER_BLOCK_HEAD_MAGIC_SD; //size: B
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
    int i;
    for (i = 0; i < BLOCKSIZE_SD; i++)
    {
        inode_bitmap_buffer[i] = 0x00;
    }
    inode_bitmap_buffer[0] = 0x1;
    sync_inode_bitmap();
}

static int set_root_inode()
{
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
    sdwrite(&root_node, superblock.inode_start, sizeof(inode_sd_t));
}

static int set_root_dir()
{
    memset(mkdir_buffer, 0, sizeof(mkdir_buffer));
    insert_sys_dir(superblock.inode_start, superblock.inode_start);
    current_dir = superblock.inode_start;
    int i;
    for (i = 0; i < sizeof(mkdir_buffer); i++)
    {
        dir_buffer[i] = mkdir_buffer[i];
    }
    sync_dir();
    return 0;
}

static int load_superblock()
//return 1 if load_sblock failed
{
    sdread(&superblock, FSSTART_SD, sizeof(superblock_head_sd_t));
    if (superblock.superblock_head_magic == SUPER_BLOCK_HEAD_MAGIC_SD)
    {
        return 0; //succeed
    }
    return 1;
    //failed
}

uint32_t block_alloc_cnt;
uint32_t inode_alloc_cnt;

static uint32_t alloc_inode()
//return the new inode's addr if succeed.
//return 0 if failed.
{
    //TODO: use faster method
    int a, b;
    for (a = 0; a < sizeof(inode_bitmap_buffer); a++)
    {
        for (b = 0; b < 8; b++)
        {
            if (BITMAP(inode_bitmap_buffer[a], b) == 0)
            {
                //succeed in finding
                BITMAP_SET1(inode_bitmap_buffer[a], b);
                sync_inode_bitmap();
                return ((a * 8 + b) * sizeof(inode_sd_t) + superblock.inode_start);
            }
        }
    }

    superblock.inode_num++;
    sync_sblock();
    return 0; //failed
}

static uint32_t alloc_block()
//return the new block's addr if succeed.
//return 0 if failed.
{
    //TODO: use faster method
    int a, b;
    for (a = 0; a < sizeof(block_bitmap_buffer); a++)
    {
        for (b = 0; b < 8; b++)
        {
            if (BITMAP(block_bitmap_buffer[a], b) == 0)
            {
                //succeed in finding
                BITMAP_SET1(block_bitmap_buffer[a], b);
                sync_block_bitmap_all();
                diskaddr_t newblock = (a * 8 + b) * BLOCKSIZE_SD + superblock.data_start;

                //clear new block
                char buff[4096];
                int h = 0;
                for (h = 0; h < 4096; h++)
                {
                    buff[h] = 0;
                }
                sdwrite(buff, newblock, 4096);
                return newblock;
            }
        }
    }

    superblock.data_size += 4096;
    sync_sblock();
    return 0; //failed
}

//Remark: do free_block first, then free inode.
static uint32_t free_inode(diskaddr_t addr)
//free inode from bitmap.
//do make sure that you give a valid addr.
{
    int position = ((addr - superblock.inode_start) / sizeof(inode_sd_t));
    int a, b;
    a = position / 8;
    b = position % 8;
    BITMAP_SET0(inode_bitmap_buffer[a], b);
    sync_inode_bitmap();
    superblock.inode_num--;
    sync_sblock();
    return 0;
}

static uint32_t free_block(diskaddr_t addr)
{
    int position = ((addr - superblock.data_start) / BLOCKSIZE_SD);
    int a, b;
    a = position / 8;
    b = position % 8;
    BITMAP_SET0(block_bitmap_buffer[a], b);
    sync_block_bitmap_all();
    superblock.data_size -= 4096;
    sync_sblock();
    return 0;
}

static int path_add(char *name)
{
    os_assert(current_dir_level < DIR_DEPTH_MAX);
    current_dir_level++;
    strcpy(current_dir_name[current_dir_level], name);
    return 0;
}

static int path_leave()
{
    os_assert(current_dir_level > 0);
    current_dir_level--;
}

static int path_reset()
{
    current_path_string[0] = '/';
    current_path_string[1] = '0';
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

    //set global vars
    current_dir_level = 0;
    current_dir_name[0][0] = '\0';
    current_dir = (diskaddr_t)superblock.inode_start;
    root_dir = (diskaddr_t)superblock.inode_start;

    //set block bitmap
    //set buffer to 1
    set_block_bitmap(block_num);

    //set inode bitmap
    set_inode_bitmap();

    //set root inode
    set_root_inode();

    //set root dir
    set_root_dir();

    //set "pwd"
    path_reset();

    return 0;
}
// mkfs 初始化文件系统

int mnt_sd()
// mnt 挂载文件系统
// return 0 if succeed
// reutrn 1 if failed
{
    if (load_superblock()) //load_sblock failed
    {
        return 1;
    }

    // load_superblock();//load_sblock failed
    load_block_bitmap();
    load_inode_bitmap();
    path_reset();

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
    memset(&mkdir_buffer, 0, BLOCKSIZE_SD);
    ((dir_t *)mkdir_buffer)->file_num = 0;
    insert_sys_dir((diskaddr_t)inode, (diskaddr_t)current_dir);

    inode_sd_t new_inode;
    new_inode.blocks[0] = block;
    new_inode.create_timestamp = 0;
    new_inode.type = FILETYPE_DIR;

    // write_dir(block);

    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (!((dir_t *)dir_buffer)->dentry[i].valid)
        {
            sdwrite(mkdir_buffer, block, 4096);
            write_inode(inode, &new_inode);
            ((dir_t *)dir_buffer)->dentry[i].valid = 1;
            ((dir_t *)dir_buffer)->dentry[i].inode = inode;

            int j = 0;
            while (name[j])
            {
                ((dir_t *)dir_buffer)->dentry[i].name[j] = name[j];
                j++;
            }
            ((dir_t *)dir_buffer)->file_num -= 1;
            sync_dir();
            printf("Made dir %s.\n", name);
            return 0;
        }
    }

    printf("Too much file in a dir.\n");
    return 9;
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
    os_assert(((dir_t *)dir_buffer)->file_num >= 2);
    if (((dir_t *)dir_buffer)->file_num > 2)
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
                diskaddr_t inode_addr = ((dir_t *)dir_buffer)->dentry[i].inode;
                free_block(inode_to_block(inode_addr));
                free_inode(inode_addr);
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

#define pprintf(x) printf("" #x ": 0x%x\n", x);

int fs_info_sd()
// statfs 打印文件系统信息，包括数据块的使用情况等
{
    if (superblock.superblock_head_magic != SUPER_BLOCK_HEAD_MAGIC_SD)
    {
        printf("file system SDfs not found.");
        return 0;
    }
    pprintf(superblock.fs_size);
    pprintf(superblock.fs_start);
    pprintf(superblock.fs_end);
    pprintf(superblock.inode_size);
    pprintf(superblock.inode_num);
    pprintf(superblock.inode_start);
    pprintf(superblock.inode_map_size);
    pprintf(superblock.inode_map_start);
    pprintf(superblock.block_map_size);
    pprintf(superblock.block_map_start);
    pprintf(superblock.data_size);
    pprintf(superblock.data_start);
    return 0;
}

static int parse_path(char *path)
{
    int i = 0;
    int p = 0;
    int inlinep = 0;
    name_pointer = 0;
    dir_depth = 0;
    if (path[p] == '/') //absolute path
    {
        absolute_path = 1;
        p++;
    }
    else //realtive path
    {
        absolute_path = 0;
    }
    while (path[p] != '\0')
    {
        if (path[p] != '/')
        {
            parsed_dir_name[i][inlinep++] = path[p++];
        }
        else
        {
            parsed_dir_name[i][inlinep] = '\0';
            inlinep = 0;
            p++;
            dir_depth++;
        }
    }
    return dir_depth;
}

static int detect_dir(diskaddr_t dir_now)
//return the dir's position if the path is right
//note: the lower level dir is not checked.
//need check outside if the result is a dir's inode
//ie: return the lowest level element's inode in path
{
    char buff[512];
    inode_sd_t inodebuff;
    dir_t dirbuff;

    //load inode into memory
    sdread(buff, ALIGN_512(dir_now), 512);
    inodebuff = *(inode_sd_t *)(&buff[dir_now % 512]);
    if (inodebuff.type != FILETYPE_DIR)
    {
        return 0;
    }
    sdread(buff, ALIGN_512(inodebuff.blocks[0]), 512);
    dirbuff = *(dir_t *)(&buff[0]);

    //search for dir named parsed_dir_name[name_pointer];
    int l;
    int find_flag = 0;
    for (l = 0; l < DIR_FILE_MAX; l++)
    {
        if (dirbuff.dentry[l].valid)
        {
            if (!strcmp(dirbuff.dentry[l].name, parsed_dir_name[name_pointer]))
            {
                find_flag = 1;
                dir_now = dirbuff.dentry[l].inode;
            }
        }
    }

    if (dir_depth == 0)
    {
        return dir_now;
    }
    else
    {
        dir_depth -= 1;
        return detect_dir(dir_now);
    }
}

int enter_fs_sd(char *path)
// cd 进入目录 (内部递归实现?)
{
    diskaddr_t temp_inode;
    parse_path(path);
    if (absolute_path)
    {
        temp_inode = detect_dir(root_dir);
    }
    else
    {
        temp_inode = detect_dir(current_dir);
    }

    if (temp_inode)
    {
        char buff[512];
        inode_sd_t inodebuff;

        //load inode into memory
        sdread(buff, ALIGN_512(temp_inode), 512);
        inodebuff = *(inode_sd_t *)(&buff[temp_inode % 512]);
        if (inodebuff.type != FILETYPE_DIR)
        {
            printf("cd: Find a file/link, not a dir.\n");
            return 1;
        }
        int i;
        for (i = 0; i < 512; i++)
        {
            //load dir to mem
            dir_buffer[i] = buff[i];
        }
    }

    if (temp_inode)
    //the path is right
    {
        if (absolute_path)
        {
            int j = 0;
            while (path[j])
            {
                current_path_string[j] = path[j];
                j++;
            }
            current_path_string[j] = path[j];
        }
        else
        {
            int i = 0, j = 0;
            while (current_path_string[i])
            {
                i++;
            }
            while (path[j])
            {
                current_path_string[i++] = path[j++];
            }
            current_path_string[i++] = path[j++];
        }
        return 0;
    }
    else
    {
        printf("cd: Invalid path.\n");
        return 1;
    }
}

diskaddr_t path_to_inode(char *path)
// cd 进入目录 (内部递归实现?)
{
    diskaddr_t temp_inode;
    parse_path(path);
    if (absolute_path)
    {
        temp_inode = detect_dir(root_dir);
    }
    else
    {
        temp_inode = detect_dir(current_dir);
    }

    return temp_inode;
}

// 文件操作
// 函数名 shell 命令 说明
int mknod_sd(char *name)
{
    //check if the name is valid
    if (!strcmp(name, "."))
    {
        printf("You can not make file '.'\n");
        return 1;
    }
    if (!strcmp(name, ".."))
    {
        printf("You can not make file '..'\n");
        return 2;
    }
    if (!strcmp(name, ""))
    {
        printf("You can not make file with empty name.\n");
        return 3;
    }
    int i;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[i].name))
            {
                printf("File %s already exists.\n", name);
                return 4;
            }
        }
    }

    //get block position on disk
    // uint32_t block = alloc_block();
    // if (!block)
    //     return 5;

    //will not alloc space for file.
    //space alloc will be done in write
    //if read non alloced space, return 0

    //get inode position on disk
    uint32_t inode = alloc_inode();
    if (!inode)
        return 6;
    //setup sys dir

    inode_sd_t new_inode;
    new_inode.type = FILETYPE_FILE;
    new_inode.hardlink_cnt = 1;
    new_inode.size = 0;
    int j;
    for (j = 0; j < 16; j++)
    {
        new_inode.blocks[j] = 0;
    }
    new_inode.create_timestamp = 0;

    write_inode(inode, &new_inode);
    printf("Made file %s.\n", name);

    return 0;
}
// touch 建立一个文件

int cat_sd(char *name)
// cat 将文件的内容打印到屏幕
// this function will only print the content of block 0;
{
    int i;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[i].name))
            {
                char ibuff[512];
                diskaddr_t inode = ((dir_t *)dir_buffer)->dentry[i].inode;
                sdread(ibuff, ALIGN_512(inode), 512);
                inode_sd_t inodebuff = *(inode_sd_t *)(&ibuff[inode % 512]);
                int size = inodebuff.size;
                if (size > 4096)
                {
                    printf("cat: Too large to cat.\n");
                    return 1;
                }
                int offset = 0;
                char buff[4096];
                sdread(buff, inodebuff.blocks[0], 4096);
                int now = 0;
                while (now < size)
                {
                    printf("%c", buff[now++]);
                }
            }
        }
    }
    printf("File %s not found.\n", name);
}

int open_sd(char *name, int access)
// 打开一个文件
{
    //check filename and open file
    if (!strcmp(name, "."))
    {
        printf("You can not open file '.'\n");
        return 1;
    }
    if (!strcmp(name, ".."))
    {
        printf("You can not open file '..'\n");
        return 2;
    }
    if (!strcmp(name, ""))
    {
        printf("You can not open file with empty name.\n");
        return 3;
    }
    int i;
    diskaddr_t file_inode = 0;
    for (i = 0; i < DIR_FILE_MAX; i++)
    {
        if (((dir_t *)dir_buffer)->dentry[i].valid)
        {
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[i].name))
            {
                file_inode = ((dir_t *)dir_buffer)->dentry[i].inode;
            }
        }
    }

    //check access
    if ((access != O_RD) || (access != O_WR) || (access != O_RDWR))
    {
        printf("Invalid access in fopen. Fopen failed.\n");
        return 4;
    }

    //load inode
    char buff[512];
    inode_sd_t *inodebuff;
    sdread(buff, ALIGN_512(file_inode), 512);
    inodebuff = (inode_sd_t *)(&buff[file_inode % 512]);
    if (inodebuff->type == FILETYPE_DIR)
    {
        printf("[FOPEN] Can not fopen a dir.\n");
        return 8;
    }

    //find and setup a free fd
    int j;
    for (j = 0; j < FDESC_NUM; j++)
    {
        if (!fdesc[j].valid)
        {
            fdesc[j].valid = 1;
            fdesc[j].access = access;
            fdesc[j].inode = file_inode;

            //open inode
            fdesc[j].mode_mask = inodebuff->mode_mask;
            fdesc[j].pos = 0;
            fdesc[j].inode_buffer = *(inode_sd_t *)(&buff[file_inode % 512]);
        }
    }

    printf("[FOPEN] No free file descripter found.\n");
    return 9;
}

static diskaddr_t seek_block(int fdesc_num, int offset)
//this func is for fwrite
//for fread: check the offset is in bound before using this func.
//before running this func, make sure that the newest inode is buffed in fdsc.inode_buffer
{
    //fst 16 blocks
    //16*4KB=64KB
    if (offset < 4096 * 16)
    {
        int block_num = offset / 4096;
        diskaddr_t res = fdesc[fdesc_num].inode_buffer.blocks[block_num];
        if (!res)
        {
            //projection has not been established
            res = alloc_block();
            if (!res)
            {
                printf("Alloc new block failed.\n");
            }
            fdesc[fdesc_num].inode_buffer.blocks[block_num] = res;
            if (fdesc[fdesc_num].inode_buffer.size < offset)
            {
                fdesc[fdesc_num].inode_buffer.size = ((offset % 4096) ? (offset - offset % 4096 + 4096) : offset);
            }
            write_inode(fdesc[fdesc_num].inode, &fdesc[fdesc_num].inode_buffer);
        }
        fdesc[fdesc_num].pos = offset;
        return res;
    }

    //l1 blocks
    //4096/4*4KB=4096KB
    if (offset < 4096 * (16 + 1024))
    {
        int block_num = (offset - (4096 * 16)) / 4096;

        if (!fdesc[fdesc_num].inode_buffer.ext_inode1)
        {
            fdesc[fdesc_num].inode_buffer.ext_inode1 = alloc_block();
            write_inode(fdesc[fdesc_num].inode, &fdesc[fdesc_num].inode_buffer);
        }

        char buff[4096];
        sdread(buff, fdesc[fdesc_num].inode_buffer.ext_inode1, 4096);

        diskaddr_t res = ((diskaddr_t *)buff)[block_num];
        if (!res)
        {
            //projection has not been established
            res = alloc_block();
            if (!res)
            {
                printf("Alloc new block failed.\n");
            }
            ((diskaddr_t *)buff)[block_num] = res;
            if (fdesc[fdesc_num].inode_buffer.size < offset)
            {
                fdesc[fdesc_num].inode_buffer.size = ((offset % 4096) ? (offset - offset % 4096 + 4096) : offset);
            }
            write_inode(fdesc[fdesc_num].inode, &fdesc[fdesc_num].inode_buffer);
            sdwrite(buff, fdesc[fdesc_num].inode_buffer.ext_inode1, 4096);
        }
        fdesc[fdesc_num].pos = offset;
        return res;
    }

    //l2 blocks
    //1024*1024*4KB=4GB

    {
        int block_num = (offset - (4096 * (16 + 1024))) / 4096 / 1024;
        int block_num2 = (offset - (4096 * (16 + 1024))) / 4096 % 1024;

        if (!fdesc[fdesc_num].inode_buffer.ext_inode2)
        {
            fdesc[fdesc_num].inode_buffer.ext_inode2 = alloc_block();
        }

        char buff1[4096];
        sdread(buff1, fdesc[fdesc_num].inode_buffer.ext_inode2, 4096);

        diskaddr_t res1 = ((diskaddr_t *)buff1)[block_num];
        if (!res1)
        {
            //projection has not been established
            res1 = alloc_block();
            if (!res1)
            {
                printf("Alloc new block failed.\n");
            }
            ((diskaddr_t *)buff1)[block_num] = res1;
            sdwrite(buff1, fdesc[fdesc_num].inode_buffer.ext_inode2, 4096);
        }

        char buff2[4096];
        sdread(buff2, res1, 4096);
        diskaddr_t res2 = ((diskaddr_t *)buff2)[block_num2];

        diskaddr_t res;

        if (!res2)
        {
            //projection has not been established
            res2 = alloc_block();
            if (!res2)
            {
                printf("Alloc new block failed.\n");
            }
            ((diskaddr_t *)buff2)[block_num2] = res2;
            sdwrite(buff2, res1, 4096);
        }

        if (fdesc[fdesc_num].inode_buffer.size < offset)
        {
            fdesc[fdesc_num].inode_buffer.size = ((offset % 4096) ? (offset - offset % 4096 + 4096) : offset);
        }
        fdesc[fdesc_num].pos = offset;
        write_inode(fdesc[fdesc_num].inode, &fdesc[fdesc_num].inode_buffer);
        return res;
    }

    //l3 blocks
    //not used
}

int read_sd(int fd, char *buff, int size)
// 读一个文件
{
    //read fd

    char sdbuff[4096];

    int can_read = 4096 - fdesc[fd].pos % 4096;
    int read_start = fdesc[fd].pos % 4096;
    uint32_t readed = 0;

    diskaddr_t daddr = seek_block(fd, fdesc[fd].pos);
    sdread(sdbuff, daddr, 4096);

    if ((size + fdesc[fd].pos) > fdesc[fd].inode_buffer.size)
    {
        printf("[READ] Warning: read exceed file size, will extend file with 0\n");
    }

    //1st round
    //read no more than can_read

    if (readed < size)
    {
        int h = read_start;
        while (can_read-- > 0)
        {
            if (readed < size)
            {
                buff[readed++] = sdbuff[h++];
                fdesc[fd].pos++;
            }
            else
            {
                return 0;
            }
        }
    }
    else
    {
        return 0;
    }

    //2nd round
    //read no more than 4096
    while (readed < size)
    {
        daddr = seek_block(fd, fdesc[fd].pos);
        sdread(sdbuff, daddr, 4096);
        can_read = 4096;
        int h = 0;
        while (can_read-- > 0)
        {
            if (readed < size)
            {
                buff[readed++] = sdbuff[h++];
                fdesc[fd].pos++;
            }
            else
            {
                return 0;
            }
        }
    }
}

int write_sd(int fd, char *buff, int size)
// 写一个文件
{
    //read fd

    char sdbuff[4096];

    int can_write = 4096 - fdesc[fd].pos % 4096;
    int write_start = fdesc[fd].pos % 4096;
    uint32_t writed = 0;

    diskaddr_t daddr = seek_block(fd, fdesc[fd].pos);
    sdread(sdbuff, daddr, 4096);

    if ((size + fdesc[fd].pos) > fdesc[fd].inode_buffer.size)
    {
        printf("[WRITE] Write exceed file size, will extend file.\n");
    }

    //1st round
    //read no more than can_read

    if (writed < size)
    {
        int h = write_start;
        while (can_write-- > 0)
        {
            if (writed < size)
            {
                sdbuff[h++] = buff[writed++];
                fdesc[fd].pos++;
            }
            else
            {
                sdwrite(sdbuff, daddr, 4096);
                return 0;
            }
        }
    }
    else
    {
        return 0;
    }
    sdwrite(sdbuff, daddr, 4096);

    //2nd round
    //read no more than 4096
    while (writed < size)
    {
        daddr = seek_block(fd, fdesc[fd].pos);
        sdread(sdbuff, daddr, 4096);
        can_write = 4096;
        int h = 0;
        while (can_write-- > 0)
        {
            if (writed < size)
            {
                sdbuff[h++] = buff[writed++];
                fdesc[fd].pos++;
            }
            else
            {
            }
        }
        sdwrite(sdbuff, daddr, 4096);
    }

    return 0;
}

int close_sd(int fd)
// 关闭一个文件
{
    //just close fd
    if (fdesc[fd].valid == 0)
    {
        printf("[FCLOSE] fd: %d has not been opened.\n", fd);
        return 1;
    }
    fdesc[fd].valid = 0;
    return 0;
}

diskaddr_t find_sd_sub(diskaddr_t dir_now, char *name)
{
    //check if dir now is a valid dir
    char buff[512];
    char dbuff[512];
    uint32_t offset = dir_now % 512;
    sdread(&buff, dir_now - offset, 512);
    inode_sd_t *inodebuff = (inode_sd_t *)(&buff[offset]);

    //not this file

    if (inodebuff->type == FILETYPE_DIR)
    {
        //load dir into memory
        sdread(dbuff, inodebuff->blocks[0], 512);
        dir_t *dirbuff = (dir_t *)dbuff;
        int k = 0;
        for (k = 0; k < DIR_FILE_MAX; k++)
        {
            if (dirbuff->dentry[k].valid)
            {
                //check if is this file
                if (!strcmp(name, dirbuff->dentry[k].name))
                {
                    //is this one
                    return dirbuff->dentry[k].inode;
                }
                else
                {
                    diskaddr_t res = find_sd_sub(dirbuff->dentry[k].inode, name);
                    if (res)
                        return res;
                }
            }
        }
        //not find here
        return 0;
    }
    else
    {
        return 0;
    }
}

int find_sd(char *path, char *name)
{
    // First we get path's addr and inode
    diskaddr_t dir_now;
    diskaddr_t res = find_sd_sub(dir_now, name);
    if (res)
    {
        printf("Find file/dir at diskaddr %x\n", res);
    }
    else
    {
        printf("File/dir not found.\n");
    }
}

int rename_sd(char *old_name, char *new_name)
{
    int k = 0;
    for (k = 0; k < DIR_FILE_MAX; k++)
    {
        if (((dir_t *)dir_buffer)->dentry[k].valid)
        {
            //check if is this file
            if (!strcmp(old_name, ((dir_t *)dir_buffer)->dentry[k].name))
            {
                //is this one
                int h = 0;
                while (new_name[h])
                {
                    ((dir_t *)dir_buffer)->dentry[k].name[h] = new_name[h];
                    h++;
                }
                ((dir_t *)dir_buffer)->dentry[k].name[h] = 0;
                sync_dir();

                printf("Rename: File renamed.\n");
                return 0;
            }
        }
    }
    printf("Rename: File not found.\n");
    return 1; //failed
}

int hardlink_sd(char *target, char *linkname)
{
    // will not setup new inode
    diskaddr_t inode = path_to_inode(target);
    if (inode)
    {
        char buff[512];
        sdread(buff, ALIGN_512(inode), 512);
        inode_sd_t *inodebuff = (inode_sd_t *)(&buff[inode % 512]);

        inodebuff->hardlink_cnt++;
        write_inode(inode, inodebuff)
    }
    else
    {
        printf("[LN] Target not found.\n");
        return 1;
    }
    //look for target, then add its inode to this dir, while
}

int softlink_sd(char *target, char *linkname)
{
    //not implemented, too many codes to write.
    printf("Too complected..., need to mod open, close, cat\n");
    return 0;
}

int recycle_blocks(diskaddr_t inode)
///note: no call recycle_blocks before call free_inode
{
    char buff[512];
    sdread(buff, ALIGN_512(inode), 512);
    inode_sd_t *inodebuff = (inode_sd_t *)(&buff[inode % 512]);

    //in inode blocks
    int i;
    for (i = 0; i < 16; i++)
    {
        if (inodebuff->blocks[i])
        {
            free_block(inodebuff->blocks[i]);
        }
    }
    //l1 blocks
    if (inodebuff->ext_inode1)
    {
        char buff1[4096];
        sdread(buff1, inodebuff->ext_inode1, 4096);
        int k = 0;
        for (k = 0; k < 1024; k++)
        {
            if (((diskaddr_t *)buff1)[k] != 0)
            {
                free_block((diskaddr_t*)buff1)[k]);
            }
        }
        free_block(inodebuff->ext_inode1);
    }
    //l2 blocks
    if (inodebuff->ext_inode2)
    {
        char buff1[4096];
        sdread(buff1, inodebuff->ext_inode1, 4096);
        int k = 0;
        for (k = 0; k < 1024; k++)
        {
            if (((diskaddr_t *)buff1)[k] != 0)
            {

                char buff2[4096];
                sdread(buff2, ((diskaddr_t *)buff1)[k], 4096);
                int s = 0;
                for (s = 0; s < 1024; s++)
                {
                    if (((diskaddr_t *)buff2)[s] != 0)
                    {
                        free_block((diskaddr_t*)buff2[s]);
                    }
                }

                free_block((diskaddr_t*)buff1)[k]);
            }
        }
        free_block(inodebuff->ext_inode1);
    }
    //l3 blocks(not used)
    return 0;
}

int rm_sd(char *name)
{
    int k = 0;
    for (k = 0; k < DIR_FILE_MAX; k++)
    {
        if (((dir_t *)dir_buffer)->dentry[k].valid)
        {
            //check if is this file
            if (!strcmp(name, ((dir_t *)dir_buffer)->dentry[k].name))
            {
                //is this one
                diskaddr_t inode = ((dir_t *)dir_buffer)->dentry[k].inode;
                if (inode)
                {
                    char buff[512];
                    sdread(buff, ALIGN_512(inode), 512);
                    inode_sd_t *inodebuff = (inode_sd_t *)(&buff[inode % 512]);

                    inodebuff->hardlink_cnt--;
                    if (inodebuff->hardlink_cnt > 0)
                    {
                        write_inode(inode, inodebuff);
                        printf("Rm: File removed. (yet there is still hl.)\n");
                        return 0;
                    }
                    else
                    {
                        ((dir_t *)dir_buffer)->dentry[k].valid = 0;
                        //TODO recycle inode
                        //TODO recycle blocks
                        recycle_blocks(inode);
                        free_inode(inode);
                        sync_dir();
                        printf("Rm: File removed.\n");
                        return 0;
                    }
                }
            }
        }
    }
    printf("Rm: File not found.\n");
    return 1; //failed
}

//TODO 包装系统调用 1
//TODO 文件操作函数
//TODO SEEK函数
//TODO LN函数
//TODO RM
//TODO 修正..的path问题
//TODO BONUS 测试样例
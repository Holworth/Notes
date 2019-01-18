// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                        File System
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
#include "shell.h"

char filetype_file_str[] = "file";
char filetype_dir_str[] = "dir";
char filetype_sl_str[] = "softlink";
char filetype_hl_str[] = "hardlink";

char *filetype(char type)
{
    switch (type)
    {
    case FILETYPE_FILE:
        return filetype_file_str;
    case FILETYPE_DIR:
        return filetype_dir_str;
    case FILETYPE_SL:
        return filetype_sl_str;
    case FILETYPE_HL:
        return filetype_hl_str;
    default:
        // panic("undefined filetype");
        return filetype_sl_str;
    }
}

// 目录操作
// 函数名 shell 命令 说明
// TODO para check
int mkfs(uint32_t size)
// mkfs 初始化文件系统
{
    return global_fs->mkfs(size);
}

int mnt()
{
    return global_fs->mnt();
}

int mkdir(char *name)
// mkdir 创建目录
{
    return global_fs->mkdir(name);
}
int rmdir(char *name)
// rmdir 删除目录
{
    return global_fs->rmdir(name);
}
int read_dir()
// ls 打印目录目录的内容
{
    return global_fs->read_dir();
}
int fs_info()
// statfs 打印文件系统信息，包括数据块的使用情况等
{
    return global_fs->fs_info();
}
int enter_fs(char *path)
// cd 进入目录 (递归实现?)
{
    return global_fs->enter_fs(path);
}

// 文件操作
// 函数名 shell 命令 说明
int mknod(char *name)
// touch 建立一个文件
{
    return global_fs->mknod(name);
}

int rm(char *name)
// touch 建立一个文件
{
    return global_fs->rm(name);
}

int cat(char *name)
// cat 将文件的内容打印到屏幕
{
    return global_fs->cat(name);
}
int open(char *name, int access) // 打开一个文件
{
    return global_fs->open(name, access);
}

int read(int fd, char *buff, int size)
// 读一个文件
{
    return global_fs->read(fd, buff, size);
}
int write(int fd, char *buff, int size)
// 写一个文件
{
    return global_fs->write(fd, buff, size);
}

int seek(int fd, uint32_t offset)
{
    fdesc[fd].pos = offset;
}

int close(int fd)
// 关闭一个文件
{
    return global_fs->close(fd);
}

int find(char *path, char *name)
{
    return global_fs->find(path, name);
}
int rename(char *old_name, char *new_name)
{
    return global_fs->rename(old_name, new_name);
}

int hardlink(char *target, char *linkname)
{
    return global_fs->hardlink(target, linkname);
}

int softlink(char *target, char *linkname)
{
    return global_fs->softlink(target, linkname);
}

void cmd_ln(char *target, char *linkname, char *para)
{
    if (!strcmp(para, "-s"))
    {
        softlink(target, linkname);
    }
    else
    {
        hardlink(target, linkname);
    }
}

int sdread_not_aligned(char *buff, uint32_t position, uint32_t size)
{
    //test if position is 512 aligned
    uint32_t position_offset = (position % 512);
    uint32_t size_offset = (position % 512);

    if (!position_offset)
    {
        if (!size_offset)
        {
            sdread(buff, position, size);
            return 0;
        }
        else
        {
            uint32_t tail_offset = size - size_offset;
            sdread(buff, position, size - size_offset);
            char tmp_buff[512];
            sdread(tmp_buff, position + size - size_offset, 512);
            int i;
            for (i = 0; i < size_offset; i++)
            {
                buff[tail_offset + i] = tmp_buff[i];
            }
            return 0;
        }
    }
    else
    {
        char tmp_buff[512];
        uint32_t start_position = position - position % 512;

        // int valid_size=512-position%512;
        int valid_offset = position % 512;
        int current_offset = 0;
        do
        {
            sdread(tmp_buff, start_position, 512);
            while (valid_offset < 512)
            {
                buff[current_offset++] = tmp_buff[valid_offset++];
                if (current_offset == size)
                    break;
            }
            valid_offset = 0;
        } while (current_offset < size);
        return 0;
    }
}

int sdwrite_not_aligned(char *buff, uint32_t position, uint32_t size)
{
    //test if position is 512 aligned
    uint32_t position_offset = (position % 512);
    uint32_t size_offset = (position % 512);

    if (!position_offset)
    {
        if (!size_offset)
        {
            sdwrite(buff, position, size);
            return 0;
        }
        else
        {
            uint32_t tail_offset = size - size_offset;
            char tmp_buff[512];
            sdread(tmp_buff, position + size - size_offset, 512);
            int i;
            for (i = 0; i < size_offset; i++)
            {
                tmp_buff[i] = buff[tail_offset + i];
            }
            sdwrite(buff, position, size - size_offset);
            sdwrite(tmp_buff, position + size - size_offset, 512);
            return 0;
        }
    }
    else
    {
        char tmp_buff[512];
        uint32_t position_now = position - position % 512;

        int valid_offset = position % 512;
        int copyed_now = 0;
        do
        {
            sdread(tmp_buff, position_now, 512);
            while (valid_offset < 512)
            {
                if (copyed_now < size)
                    tmp_buff[valid_offset++] = buff[copyed_now++];
            }
            sdwrite(tmp_buff, position_now, 512);
            valid_offset = 0;
        } while (copyed_now < size);

        // int valid_size=512-position%512;
        return 0;
    }
}
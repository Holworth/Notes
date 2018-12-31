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
        panic("undefined filetype");
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
    panic("TBD");
}

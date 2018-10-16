scp C:\Users\autum\download2\Anaconda2-5.3.0-Linux-x86_64.sh root@124.16.70.64:/home/tmp_setupenv
yum

groupadd student

add_student()
{
    echo $1
    sudo useradd -c "Student account for $1" -d /home/student/$1 -m $1 -g student 
    passwd -d $1
    passwd -f $1
}

批量操作 ref: http://www.runoob.com/linux/linux-user-manage.html

crontab: http://www.runoob.com/w3cnote/linux-crontab-tasks.html

+

shell ref: https://zhidao.baidu.com/question/2118024779094212987.html

use w to see current Users

grep + w + crontab + shell


crontab -e
counter:
*/5 * * * * ./count_time.sh

每条任务调度执行完毕，系统都会将任务输出信息通过电子邮件的形式发送给当前系统用户，这样日积月累，日志信息会非常大，可能会影响系统的正常运行，因此，将每条任务进行重定向处理非常重要。 例如，可以在crontab文件中设置如下形式，忽略日志输出:

0 */3 * * * /usr/local/apache2/apachectl restart >/dev/null 2>&1

add:
30 21 * * * logout >/dev/null 2>&1
(logout in 21:30)
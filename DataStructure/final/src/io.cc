#ifndef IO_CC_
#define IO_CC_

#include "head.cc"
#include "cppext.cc"//extend cpp with string.spilt(): spilt
#include <sstream>
#include <iostream>
#include <fstream>

using namespace std;

// 函数列表
// int show_path(class Trans *src);
// int show_path();
// int Time::interactive_input();
// int Trans::interactive_input();
// int interactive_input();
// int save_city();
// int save_run();
// int read_city();
// int read_run();

string run_file = "run.csv";
string city_file = "city.csv";

int show_path(class Trans *src)//显示某一次列车/航班的信息
{
    cout << "------------------------------" << endl
         << ((src->type_ == train) ? "TRAIN" : "FLIGHT") <<"   "<<src->nor_<< endl
         << "Depart from " << city_list[src->src_].name_ << " at: ";
    src->time_leave_.print();
    cout << endl
         << "Arrive in " << city_list[src->tgt_].name_ << " at: ";
    src->time_arrive_.print();
    cout << endl
         << "Duration: " << src->duration_ << "min.  Cost: " << src->cost_ << "yuan." << endl;
}

int show_path()//显示数据库中所有已经录入的列车/航班的信息
{
    cout << "Print out all runs." << endl;
    int size = city_list.size();
    for(int i = 0; i < size;i++)
    {
        Trans *p = city_list[i].trans_;
        while(p!=0)
        {
            show_path(p);
            p = p->next_;
        }
    }
}

ostream &operator<<(ostream &out, class Trans &trans)//重载<<, 将一次列车/航班的信息以文本的格式输出
{
    out << city_list[trans.src_].name_ << " "
        << city_list[trans.tgt_].name_ << " "
        << trans.type_ << " "
        << trans.nor_ << " "
        << trans.time_leave_.type_ << " "
        << trans.time_leave_ << " "
        << trans.time_arrive_<<" "
        << trans.duration_<<" "
        << trans.cost_;
    return out;
}

istream &operator>>(istream &in, class Trans &trans)//重载>>, 用于从文本文件中读取一次飞机/航班的信息
{
    string src_s;
    string tgt_s;
    in >> src_s >> tgt_s >> trans.type_ >> trans.nor_ >> trans.time_leave_.type_ >> trans.time_leave_ >> trans.time_arrive_>>trans.duration_>>trans.cost_;

    int src = hash_city(src_s);
    if (src == -1)
        add_city(src_s);
    trans.src_ = hash_city(src_s);
    int tgt = hash_city(tgt_s);
    if (tgt == -1)
        add_city(tgt_s);
    trans.tgt_ = hash_city(tgt_s);
    return in;
}

ostream &operator<<(ostream &out, Time &time)//重载>>, 用于时间结构Time的保存
{
    out << time.type_ << " "
        << time.day_ << " "
        << time.hour_ << " "
        << time.min_;
    return out;
}

istream &operator>>(istream &in, Time &time) //重载<<, 用于时间结构Time的读取
{
    in >> time.type_ >> time.day_ >> time.hour_ >> time.min_;
    return in;
}

int Time::interactive_input()//交互式时间输入
//return -1 means input failed
//return 0: input succeed
{
t_i_head:
    cout << "---------------------------------------\n"
         << "Please input the type of the train/flight:\n"
         << "1. Daily flight / Daily train.\n"
         << "2. Weekly flight / Weekly train.\n"
         << "0. Return to upper level.\n"
         << "Input:";
    // int type;
    // int day;
    // int hour;
    // int min;
    cin >> type_;
    switch (type_)
    {
    case 0:
        return -1;
    case 1:
        cout << "Now input the time: format: \"(day) hour min\"" << endl;
        cin >> hour_ >> min_;
        return 0;
        break;
    case 2:
        cout << "Now input the time: format: \"(day) hour min\"" << endl;
        cin >> day_ >> hour_ >> min_;
        return 0;
        break;
    default:
        cout << "Wrong input format, please input again.\n";
        cin.clear();
        cin.sync();
        goto t_i_head;
    }

    return 0;
}

int Trans::interactive_input()//交互式航班/列车信息输入
//return -1 means input failed
//return 0: input succeed
{
    cout << "Please input the vehicle type:\n"
         << "1. Train\n"
         << "2. Flight\n"
         << "0. Return to upper level.\n"
         << "Input:";
    cin >> type_;
    type_--;
    if (type_ <= -1)
        return -1;
    if (type_ >= 2)
        return -1;
    cout << "Please input the Number of Run/Flight(NOR/NOF), the city for departure, the city to go to, and the price." << endl
         << "The format is: \"NOR city_source city_destination price\"" << endl;
    string src_s;
    string tgt_s;
    cin >> nor_ >> src_s >> tgt_s >> cost_;
    src_ = hash_city(src_s);
    tgt_ = hash_city(tgt_s);
    if (src_ == -1)
    {
        //automaticaly add a new city
        add_city(src_s);
        src_ = hash_city(src_s);
    }
    if (tgt_ == -1)
    {
        //automaticaly add a new city
        add_city(tgt_s);
        tgt_ = hash_city(tgt_s);
    }
    cout << "Input the time for departure:\n";
    time_leave_.interactive_input();
    cout << "Input the time for arrival:\n";
    time_arrive_.interactive_input();

    duration_ = time_arrive_ - time_leave_;

    return 0;
}

int interactive_input()//交互式输入菜单
{
    while (1)
    {
        cout << "---------------------------" << endl
             << "1. Input train runs / flight" << endl
             << "2. Input cities" << endl
             << "3. Delete train runs / flight" << endl
             << "4. Delete cities" << endl
             << "0. Return to upper level" << endl
             << "Remark: when a new run/flight was added, the city it connects would be added as well." << endl
             << "Input:";
        int choose;
        cin >> choose;
        switch (choose)
        {
        case 1:
            add_path();
            break;
        case 2:
            add_city();
            break;
        case 3:
            delete_path();
            break;
        case 4:
            delete_city();
            break;
        case 0:
            return -1;
        default:
            cout << "Invalid input, please input again." << endl;
            break;
        }
    }
    return 0;
}

int save_city()//保存数据库中所有城市到指定文件, 默认为""city.csv"
{
    ofstream city_out;
    city_out.open(city_file.c_str(), ios::out);
    int size = city_list.size();
    for (int i = 0; i < size; i++)
    {
        if (!city_list[i].deleted_)
        {
            city_out << city_list[i].name_ << endl;
        }
    }
}

int save_run() //保存数据库中所有航班/列车信息到指定文件, 默认为"run.csv"
{
    ofstream run_out;
    run_out.open(run_file.c_str(), ios::out);
    int size = city_list.size();
    for (int i = 0; i < size; i++)
    {
        if (!city_list[i].deleted_)
        {
            Trans *p = city_list[i].trans_;
            while (p)
            {
                run_out << (*p) << endl;
                p = p->next_;
            }
        }
    }
    return 0;
}

int read_city() //从指定文件中读取城市列表, 加入当前的城市列表中, 默认为""city.csv"
{
    ifstream city_in;
    city_in.open(city_file.c_str(), ios::in);
    string line;
    if (city_in)
    {
        while (getline(city_in, line)) // line中不包括每行的换行符
        {
            add_city(line);
        }
        return 0;
    }
    else // 没有该文件
    {
        cout << "No such file." << endl;
        return FAILED;
    }
}

int read_run() //从指定文件中读取列车/航班信息, 加入当前的列车/航班列表中, 默认为"run.csv"
{
    ifstream run_in;
    run_in.open(run_file.c_str(), ios::in);
    if (run_in)
    {
        while (!run_in.eof()) // line中不包括每行的换行符
        {
            class Trans *temp = new Trans;
            run_in >> (*temp);
            if (city_list[temp->src_].add_path(temp)==0)
            {
                //succeed
            }
            else
            {
                delete temp;
            }
        }
        return 0;
    }
    else // 没有该文件
    {
        cout << "No such file." << endl;
        return FAILED;
    }
}

#endif
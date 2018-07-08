#ifndef IO_CC_
#define IO_CC_

#include "head.cc"
#include <sstream>
#include <iostream>
#include <fstream>

using namespace std;

// struct Record
// {
//     string src_s;
//     string tgt_s;
//     string nor;
//     Time time_leave;
//     Time time_arrive;
//     time_type time_type;
//     type_of_trans trans_type;
// };

// string rec_to_str(struct Record);
// string Trans::str()
// {
//     ostringstream stream;
//     stream << city_list[src_].name_ << ","
//            << city_list[tgt_].name_ << ","
//            << type_ << ","
//            << nor_ << ","
//            << time_leave_.type_ << ","
//            << time_leave_ << ","
//            << time_arrive_ << endl;
//     return stream.str();
// }

ostream &operator<<(ostream &out, class Trans trans)
{
    out << city_list[trans.src_].name_ << ","
        << city_list[trans.tgt_].name_ << ","
        << trans.type_ << ","
        << trans.nor_ << ","
        << trans.time_leave_.type_ << ","
        << trans.time_leave_ << ","
        << trans.time_arrive_;
    return out;
}

istream &operator>>(istream &in, class Trans trans)
{
    string src_s;
    string tgt_s;
    in >> src_s >> tgt_s >> trans.type_ >> trans.nor_ >> trans.time_leave_.type_ >> trans.time_leave_ >> trans.time_arrive_;
    trans.src_ = hash_city(src_s);
    trans.tgt_ = hash_city(tgt_s);
    return in;
}

ostream &operator<<(ostream &out, Time &time)
{
    out << time.type_ << ","
        << time.day_ << ","
        << time.hour_ << ","
        << time.min_;
    return out;
}

istream &operator>>(istream &in, Time &time)
{
    in >> time.type_ >> time.day_ >> time.hour_ >> time.min_;
    return in;
}

int Time::interactive_input()
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
        goto t_i_head;
    }

    return 0;
}

int Trans::interactive_input()
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
    cin >> nor_ >> src_ >> tgt_ >> cost_;
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

int interactive_input()
{
    while(1)
    {
    cout << "---------------------------" << endl
         << "1. Input train runs / flight" << endl
         << "2. Input cities" << endl
         << "3. Delete train runs / flight" << endl
         << "4. Delete cities" << endl
         << "0. Return to upper level" << endl
         << "Remark: when a new run/flight was added, the city it connects would be added as well.";
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
    case 4:
        delete_city();
    case 0:
        return -1;
    default:
        cout << "Invalid input, please input again." << endl;
        break;
            }
    }
    return 0;
}

int save_city()
{
    ofstream city_out;
    city_out.open("city.csv", ios::out);
    int size = city_list.size();
    for(int i=0;i<size;i++)
    {
        if(!city_list[i].deleted_)
        {
            city_out << city_list[i].name_<<endl;
        }
    }
}

int save_run()
{
    ofstream run_out;
    run_out.open("run.csv", ios::out);
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

int read_city()
{
    ifstream city_in;
    city_in.open("city.csv", ios::in);
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

int read_run()
{
    ifstream run_in;
    run_in.open("run.csv", ios::in);
    if (run_in)
    {
        while (!run_in.eof()) // line中不包括每行的换行符
        {
            class Trans *temp=new Trans;
            run_in>> (*temp);
            if(city_list[temp->src_].add_path(temp))
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
#ifndef HEAD_CC_
#define HEAD_CC_

#include <iostream>
#include <string>
#include <vector>
#include <stack>

using namespace std;

#define MAXDURATION 28800 //20 days
#define MAXCOST 50000     //50000 RMB
#define MAXSWITCH 10      //10 switches

enum weekdays
{
    daily,
    mon,
    tue,
    wen,
    thu,
    fri,
    sat,
    sun
};

enum type_of_trans
{
    train,
    plane
};

enum time_type
{
    daily,
    weekly,
    monthly
};

class Time
{
  public:
    Time()
    {
        //Do nothing
    }
    Time(int hour, int min)
    {
        hour_ = hour;
        min_ = min;
        type_ = daily;
    }
    Time(weekdays day, int hour, int min)
    {
        day_ = day;
        hour_ = hour;
        min_ = min;
        type_ = weekly;
    }
    Time(Time &src)
    {
        type_ = src.type_;
        day_ = src.day_;
        hour_ = src.hour_;
        min_ = src.min_;
    }
    Time operator=(Time src)
    {
        type_ = src.type_;
        day_ = src.day_;
        hour_ = src.hour_;
        min_ = src.min_;
        return *this;
    }

    int operator-(Time &b)
    {
        if (type_ == daily)
        {
            if (b.type_ == daily)
            {
            }
            else
            {
            }
        }
        else
        {
            if (b.type_ == daily)
            {
            }
            else
            {
            }
        }
    }

    void print()
    {
        if (type_ == weekly)
        {
            switch (day_)
            {
            case mon:
                cout << "Mon ";
                break;
            case tue:
                cout << "Tue ";
                break;
            case wen:
                cout << "Wen ";
                break;
            case thu:
                cout << "Thu ";
                break;
            case fri:
                cout << "Fri ";
                break;
            case sat:
                cout << "Sat ";
                break;
            case sun:
                cout << "Sun ";
                break;
            }
        }
        if (type_ == monthly)
            cout << day_ << " this month. ";
        // if(type_==daily)
        {
            cout << hour_ << ":" << min_;
            return;
        }
    }

    time_type type_;

    int day_;
    int hour_;
    int min_;
};

class Trans
{
  public:
    Trans(int src, int tgt, type_of_trans type, Time &time_leave, Time &time_arrive, double cost, string nor)
    {
        src_ = src;
        src_ = tgt;
        cost_ = cost;
        time_leave_ = time_leave;
        time_arrive_ = time_arrive;
        duration_ = time_arrive - time_leave;
        next_ = 0;
        nor_ = nor;
    }

    // class City *psrc_; //出发城市指针
    // class City *ptgt_; //到达城市指针
    int src_; //出发城市
    int tgt_; //到达城市
    type_of_trans type_;

    int duration_;
    double cost_;
    class Time time_leave_;
    class Time time_arrive_;

    string nor_; //number of runs/flights

    class Trans *next_;
};

class City
{
  public:
    City(string name)
    {
        trans_ = 0;
        name_ = name;
        deleted_ = 0;
    }
    string name_;
    class Trans *trans_;
    int deleted_ = 0;

    int add_path(int src, int tgt, type_of_trans type, Time &time_leave, Time &time_arrive, double cost, string nor)
    //Added a path start from this city.
    {
        class Trans *ptrans = trans_;
        class Trans **pptrans = &trans_;
        while (ptrans)
        {
            //Check if the path already exists.
            //TODO
            if (ptrans->nor_ == nor)
            {
                //Already exists.
                cout << "This run/flight already exists! Add run/flight failed\n";
                return -1;
            }
            ptrans = ptrans->next_;
            pptrans = &ptrans->next_;
        }
        (*pptrans) = new Trans(src, tgt, type, time_leave, time_arrive, cost, nor);
        return 0;
    }
};

vector<City> city_list;

int add_city(string name = "")
{
    //Judge if interactive input is needed.
    if (name == "")
    {
        cout << "Please input the name of the city to be added.\n";
        cin >> name;
    }
    //Check if the city already exists.
    int size = city_list.size();
    for (int i = 0; i < size; i++)
    {
        if (city_list[i].name_ == name)
        {
            if (!city_list[i].deleted_)
            {
                cout << "City " << name << " already exists. Add city failed.\n";
                return -1;
            }
            else
            {
                city_list[i].deleted_ = 0;
                return 0;
            }
        }
    }
    //Add the city in to the linklist/vector
    city_list.push_back(City(name));
    return 0;
}

int delete_city(string name = "")
//Remark: delete city will also delete all paths related!!!
//TODO: delete path
{
    //Judge if interactive input is needed.
    if (name == "")
    {
        cout << "Please input the name of the city to be deleted.\n";
        cin >> name;
    }
    //Check if the city already exists.
    int size = city_list.size();
    for (int i = 0; i < size; i++)
    {
        if (city_list[i].name_ == name)
        {
            //Delete the city in to the linklist/vector
            //Mark the city as deleted so that the path struct will not be damaged.
            if (city_list[i].deleted_)
            {
                cout << "City " << name << " has already been deleted\n";
            }
            else
            {
                city_list[i].deleted_ = 1;
                //TODO
                //related path not deleted now
            }
            // city_list.erase(city_list.begin() + i);
            return 0;
        }
    }
    cout << "City " << name << " do not exist. Delete city failed.\n";
    return -1;
}

int show_city()
//Print all cities.
{
    int size = city_list.size();
    cout << "Print out all cities" << endl;
    for (int i = 0; i < size; i++)
    {
        if (!city_list[i].deleted_)
            cout << city_list[i].name_ << endl;
    }
    cout << endl;
}

int hash_city(string name)
//hash city name to hash value
{
    int size = city_list.size();
    for (int i = 0; i++; i < size)
    {
        if (city_list[i].name_ == name)
        {
            if (city_list[i].deleted_)
            {
                return -1;
            }
            else
            {
                return i;
            }
        }
    }
    //Not found
    return -1;
}

int add_path(string src_s, string tgt_s, type_of_trans type, Time &time_leave, Time &time_arrive, double cost, string nor)
{
    int src = hash_city(src_s);
    if (src == -1)
        add_city(src_s);
    src = hash_city(src_s);
    int tgt = hash_city(tgt_s);
    if (tgt == -1)
        add_city(tgt_s);
    tgt = hash_city(tgt_s);
    return city_list[src].add_path(src, tgt, type, time_leave, time_arrive, cost, nor);
}

int delete_path(string nor)
{
    //TODO
}

int delete_path(string src_s, string tgt_s, string nor)
{
    int s = hash_city(src_s);
    if ((s != -1) && (!city_list[s].deleted_))
    {
        class Trans *p = city_list[s].trans_;
        class Trans **pp = &city_list[s].trans_;
        while (p != 0)
        {
            if (p->nor_ == nor)
            {
                (*pp) = p->next_;
                delete p;
            }
            pp = &p->next_;
            p = p->next_;
        }
    }
    else
    {
        cout << "City " << src_s << " does not exist" << endl;
    }
}

int show_path(class Trans *src)
{
    cout << "------------------------------" << endl
         << ((src->type_ == train) ? "TRAIN" : "FLIGHT") << endl
         << "Depart from " << city_list[src->src_].name_ << " at: ";
    src->time_leave_.print();
    cout << endl
         << "Arrive in " << city_list[src->tgt_].name_ << " at: ";
    src->time_arrive_.print();
    cout << endl
         << "Duration: " << src->duration_ << "min.  Cost: " << src->cost_ << "yuan." << endl;
}

#endif
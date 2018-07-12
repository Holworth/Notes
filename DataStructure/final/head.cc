#ifndef HEAD_CC_
#define HEAD_CC_

#include <iostream>
#include <string>
#include <vector>
#include <stack>
#include <cstdlib>
#include "ttime.cc"

using namespace std;

#define MAXDURATION 28800 //20 days
#define MAXCOST 50000     //50000 RMB
#define MAXSWITCH 10      //10 switches

#define FAILED -2
#define RETURNED -1
#define NORMALLY_ENDED 0


enum type_of_trans
{
    train,
    plane
};

class Trans
{
  public:
    Trans()
    {
        next_ = 0;
        nor_ = "";
    }

    Trans(int src, int tgt, int type, Time &time_leave, Time &time_arrive, double cost, string nor)
    {
        src_ = src;
        tgt_ = tgt;
        type_ = type;
        cost_ = cost;
        time_leave_ = time_leave;
        time_arrive_ = time_arrive;
        duration_ = time_arrive - time_leave;
        next_ = 0;
        nor_ = nor;
    }

    //io functions
    // string str();

    friend ostream &operator<<(ostream &out, class Trans &trans);
    friend istream &operator>>(istream &in, class Trans &trans);

    inline bool is_suitable_way(int way);

    int interactive_input();

    //data struct

    // class City *psrc_; //出发城市指针
    // class City *ptgt_; //到达城市指针
    int src_; //出发城市
    int tgt_; //到达城市
    // type_of_trans type_;
    int type_;

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
    class Trans *trans_=0;
    int deleted_ = 0;

    int add_path(int src, int tgt, int type, Time time_leave, Time time_arrive, double cost, string nor)
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
                return -2;
            }
            pptrans = &(ptrans->next_);
            ptrans = ptrans->next_;
        }
        (*pptrans) = new Trans(src, tgt, type, time_leave, time_arrive, cost, nor);
        return 0;
    }

    int add_path(Trans *t)
    {
        if((t->src_==-1)||(t->tgt_==-1))
        {
            return FAILED;
        }
        class Trans *ptrans = trans_;
        class Trans **pptrans = &trans_;
        while (ptrans)
        {
            //Check if the path already exists.
            //TODO
            if (ptrans->nor_ == t->nor_)
            {
                //Already exists.
                cout << "This run/flight already exists! Add run/flight failed\n";
                return FAILED;
            }
            pptrans = &(ptrans->next_);
            ptrans = ptrans->next_;
        }
        (*pptrans) = t;
        return 0;
    }

    int delete_path(string nor = "")
    {
        if (nor == "")
        {
            cout << "Please input the Number of Flight/Run (NOR):";
            cin >> nor;
        }
        class Trans *ptrans = trans_;
        class Trans **pptrans = &trans_;
        while (ptrans)
        {
            //Check if the path already exists.
            //TODO
            if (ptrans->nor_ == nor)
            {
                //Already exists.
                (*pptrans) = ptrans->next_;
                delete ptrans;
                return 0;
            }
            pptrans = &(ptrans->next_);
            ptrans = ptrans->next_;
        }
        cout << "Run/Flight " << nor << " does not exist\n";
        return -1;
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
                return FAILED;
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
    for (int i = 0; i<size; i++)
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

int add_path(string src_s, string tgt_s, int type, Time time_leave, Time time_arrive, double cost, string nor)
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

int add_path()
{
    Trans *temp = new Trans;
    if (temp->interactive_input() == RETURNED)
    {
        delete temp;
        return RETURNED;
    }
    else
    {
        if (city_list[temp->src_].add_path(temp) == FAILED)
        {
            delete temp;
            return FAILED;
        }
    }
    return 0;
}

int delete_path(string nor = "")
{
    if (nor == "")
    {
        cout << "Please input the Number of Flight/Run (NOR):";
        cin >> nor;
    }
    int size = city_list.size();
    for (int i = 0; i < size; i++)
    {
        if (!city_list[i].deleted_)
        {
            class Trans *ptrans = city_list[i].trans_;
            class Trans **pptrans = &city_list[i].trans_;
            while (ptrans)
            {
                //Check if the path already exists.
                if (ptrans->nor_ == nor)
                {
                    //Already exists.
                    (*pptrans) = ptrans->next_;
                    delete ptrans;
                    return 0;
                }
                pptrans = &(ptrans->next_);
                ptrans = ptrans->next_;
            }
        }
    }
    cout << "Run/Flight " << nor << " does not exist\n";
    return -1;
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
                return 0;
            }
            pp = &(p->next_);
            p = p->next_;
        }
        cout << "Run/Flight " << nor << " does not exist\n";
        return -1;
    }
    else
    {
        cout << "City " << src_s << " does not exist" << endl;
    }
}

int show_path(class Trans *src);

int show_path();

#endif
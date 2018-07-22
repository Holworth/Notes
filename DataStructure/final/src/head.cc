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
//边类型:作为邻接表中链表的节点，用于保存一个列车／航班的相关信息．
{
  public:
    //构造函数
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
    //操作结果: 按输入的参数构造函数

    //io functions
    // string str();

    //文件运算符重载
    friend ostream &operator<<(ostream &out, class Trans &trans);
    friend istream &operator>>(istream &in, class Trans &trans);
    //操作结果: 实现Trans结构与以空格为间隔的字符串之间的相互装换

    //查询用户要求, 判断当前的航班/列车是否满足用户要求
    inline bool is_suitable_way(int way);
    //前提条件: 用户已经输入了要求(使用何种交通工具)
    //返回结果: 若当前的边(列车/航班)满足要求则返回true, 否则返回false

    //交互式输入函数
    int interactive_input();
    //返回结果: 显示提示信息, 用户按提示信息依次输入一次列车/航班的各个属性

    //data struct

    // class City *psrc_; //出发城市指针
    // class City *ptgt_; //到达城市指针
    int src_; //出发城市
    int tgt_; //到达城市
    // type_of_trans type_;
    int type_;//当前边的类型: 飞机或者火车

    int duration_;//当前边从出发到抵达的时间. 在边的结构被建立的时候自动进行计算.
    double cost_;//当前边的票价
    class Time time_leave_;//出发时间
    class Time time_arrive_;//到达时间

    string nor_; //number of runs/flights 列车号/航班号

    class Trans *next_;//单向链表指针, 指向下一个边节点
};

class City
//城市类型, 用于保存城市的相关信息以及作为邻接表的表头
{
  public:
    //构造函数
    City(string name)
    {
        trans_ = 0;
        name_ = name;
        deleted_ = 0;
    }
    //操作结果: 初始化一个新的城市.

    string name_;//城市名称
    class Trans *trans_=0;//指向链表首节点的指针(指向边界点的指针)
    int deleted_ = 0;//删除标记

    //添加一个从此城市出发的路线(边)
    int add_path(int src, int tgt, int type, Time time_leave, Time time_arrive, double cost, string nor)
    //前提条件: 城市已经被初始化, 添加的路线是从此城市出发的路线
    //返回结果: 若所有参数合法, 城市存在, 则在链表中添加新的路径. 若已经存在相同的路径, 则什么都不做并返回错误码
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

    //删除边(路径)
    int delete_path(string nor = "")
    //函数输入: 航班号/列车号/无(由用户交互式输入航班号/列车号))
    //返回结果: 按照输入的航班号删除对应的路线
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

//邻接表表头, 作为全局变量存在, 使用std::vector作为数据结构来实现随机访问和O(1)的添加元素操作
vector<City> city_list;

//添加城市函数
int add_city(string name = "")
//返回结果: 若城市不存在(或有删除标记), 则添加(恢复)
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

//删除城市函数
int delete_city(string name = "")
//返回结果: 若城市名有效, 则将城市标记为"删除"状态. 在之后的算法中不考虑这个城市以及所有相关的路线, 并且在整理数据库操作时有"删除"状态的边会被删除.
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

//显示当前的所有城市, 描述略
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

//伪.城市哈希
//函数输入: 城市名称字符串
//返回结果: 若城市存在, 则返回它在邻接表表头中的对应位置. 否则返回-1
//注意这里有多种实现方式. 使用键树的实现需要#include"search.cc"并使用其中的键树trie树函数.
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

//添加路径函数
//前提条件: 参数合法
//返回结果: 若涉及的城市有不在城市列表中的, 则将这个城市添加到城市列表中. 之后进行判断:如果这个路径(边)没有被添加过, 则将其添加到邻接表中
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

//交互式添加路径
//调用上面的添加路径函数, 条件结果均一致
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

//删除路径函数
//输入参数: 待删除路径的航班号/列车号
//返回结果: 删除对应路径并返回0, 若路径不存在则返回错误码
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

//与上面的函数类似
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

//显示一条路路径
int show_path(class Trans *src);

//显示当前数据库中的所有路径
int show_path();

#endif
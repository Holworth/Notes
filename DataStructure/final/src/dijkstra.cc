#include "head.cc"
#include <iostream>

using namespace std;

inline bool Trans::is_suitable_way(int way)//检查交通工具类别（列车、飞机）是否满足用户要求
{
    // 1. Train only
    // 2. Plane only
    // 3. Train &Plane
    switch (way)
    {
    case 3:
        return true;
    case 1:
        if (type_ == train)
            return true;
        return false;
    case 2:
        if (type_ == plane)
            return true;
        return false;
    }
}

class Dijkstra//最短路径算法计算引擎
{
  public:
    Dijkstra()//按城市列表大小初始化算法所需孔间
    {
        size = city_list.size();
        duration_ = new int[size];
        cost_ = new double[size];
        switch_ = new int[size];
        last_ = new int[size];
        trans_ = new class Trans *[size];
        accessed = new bool[size];
        way = 0;

        int t = size;

        for (int i = 0; i < t; i++)
        {
            trans_[i] = 0;
            duration_[i] = MAXDURATION;
            cost_[i] = MAXCOST;
            switch_[i] = MAXSWITCH;
            last_[i] = -1;
            accessed[i] = 0;
        }
    }

    int update_data()//重新设定算法所需的辅助空间.
    {
        size = city_list.size();
        delete[] duration_;
        delete[] cost_;
        delete[] switch_;
        delete[] last_;
        delete[] trans_;
        delete[] accessed;        
        duration_ = new int[size];
        cost_ = new double[size];
        switch_ = new int[size];
        last_ = new int[size];
        trans_ = new class Trans *[size];
        accessed = new bool[size];
        way = 0;

        int t = size;

        for (int i = 0; i < t; i++)
        {
            trans_[i] = 0;
            duration_[i] = MAXDURATION;
            cost_[i] = MAXCOST;
            switch_[i] = MAXSWITCH;
            last_[i] = -1;
            accessed[i] = 0;
        }
    };

    ~Dijkstra()//释放内存
    {
        delete[] duration_;
        delete[] cost_;
        delete[] switch_;
        delete[] last_;
        delete[] trans_;
        delete[] accessed;
    }

    int fastest();//从上车到下车的最快路径
    int fastest_advanced();//考虑从当前时间到到达目的地的最快路径。
    int cheapest();//耗费最少路径
    int coziest();//换乘最少路径
    int interactive_lookup();//交互式查找函数
    int show_result();//显示结果

  private:
    //graph information
    int size;//城市数目

    //source and destination
    int src;//出发城市
    int tgt;//目标城市
    string src_s; //出发城市(字符串)
    string tgt_s; //目标城市(字符串)

    //global vars for Dijkstra
    int *switch_;//换乘次数数组
    double *cost_;//车费统计数组
    int *duration_;//时间累积数组
    class Trans **trans_;//来到某个城市所采用的航班/列车指针数组
    int *last_;//记录从哪一个城市到达当前的城市

    bool *accessed;//记录这个城市是否已经求得了最短路径

    //settings
    //记录用户的要求
    int way;//记录用户要求乘坐 飞机/火车/(飞机+火车)
    int need_coziest;//记录用户是否需要换乘次数最小
    int mode;//记录用户要最小号时间成本还是票价成本
};

int Dijkstra::cheapest()//选取价格最低的路线
//主要算法的实现大同小异, 详细的注释写在最为复杂的时间最短算法实现部分
{
    //The 1st step;
    class Trans *ptrans = city_list[src].trans_;

    while (ptrans)
    {
        if ((!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
        {
            cost_[ptrans->tgt_] = ptrans->cost_;
            trans_[ptrans->tgt_] = ptrans;
            last_[ptrans->tgt_] = ptrans->src_;
        }
        ptrans = ptrans->next_;
    }

    accessed[src] = 1;

    // Loop for n-1 times
    for (int i = 1; i < size; i++)
    {
        //TODO: use priority path
        //Find the minest
        double min = MAXCOST - 1;
        int min_position = -1;
        for (int a = 0; a < size; a++)
        {
            if ((!accessed[a]) && (!city_list[a].deleted_) && (ptrans->is_suitable_way(way)))
            {
                if (cost_[a] < min)
                {
                    min = cost_[a];
                    min_position = a;
                }
            }
        }
        if (min_position == -1)
        {
            //There is no other path
            break;
        }
        accessed[min_position] = 1;
        //Relaxation
        ptrans = city_list[min_position].trans_;

        while (ptrans)
        {
            if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
            {
                if ((ptrans->cost_ + cost_[min_position]) < cost_[ptrans->tgt_])
                {
                    cost_[ptrans->tgt_] = ptrans->cost_ + cost_[min_position];
                    trans_[ptrans->tgt_] = ptrans;
                    last_[ptrans->tgt_] = ptrans->src_;
                }
            }
            ptrans = ptrans->next_;
        }
    }
}

int Dijkstra::fastest()
{
    //TODO: have bug: can only be used for the same day flight/train
    //The 1st step;
    class Trans *ptrans = city_list[src].trans_;

    accessed[src] = 1;//设置出发城市为已经到达状态

    //查询所有的直达车, 即查询所有出发点的相邻边
    while (ptrans)
    {
        if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
        //满足三个条件
        //1. 城市不是起点
        //2. 城市没有被删除
        //3. 这条线路的交通方式满足用户要求

        {
            if(ptrans->duration_<duration_[ptrans->tgt_])
            //注意: 有一个点到另一个点可以有多种不同的车次, 必须要对不通过的车次也加以比较
            {
                //保存当前找到的最好路径的信息
                duration_[ptrans->tgt_] = ptrans->duration_;
                trans_[ptrans->tgt_] = ptrans;
                last_[ptrans->tgt_] = ptrans->src_;
            }

        }
        ptrans = ptrans->next_;//查询下一个路径
    }


// Loop for n-1 times
//进行n-1轮次的松弛操作
for (int i = 1; i < size; i++)
{
    //TODO: use priority path
    //Find the minest
    int min = MAXDURATION - 1;
    int min_position = -1;
    for (int a = 0; a < size; a++)
    {
        if ((!accessed[a]) && (!city_list[a].deleted_) && (ptrans->is_suitable_way(way)))
        {
            if (duration_[a] < min)
            {
                min = duration_[a];
                min_position = a;
            }
        }
    }
    if (min_position == -1)
    {
        //There is no other path
        break;
    }
    accessed[min_position] = 1;

    //Relaxation
    ptrans = city_list[min_position].trans_;

    while (ptrans)
    {
        if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
        {
            if ((ptrans->duration_ + duration_[min_position] + (ptrans->time_leave_ - ptrans[min_position].time_arrive_)) < duration_[ptrans->tgt_]) //considered the time used for transfer
            {
                duration_[ptrans->tgt_] = ptrans->duration_ + duration_[min_position];
                trans_[ptrans->tgt_] = ptrans;
                last_[ptrans->tgt_] = ptrans->src_;
            }
        }
        ptrans = ptrans->next_;
    }
    }
}

#ifdef ENABLE_PQ
int Dijkstra::fastest_with_pq()
{
    //TODO: have bug: can only be used for the same day flight/train
    //The 1st step;
    class Trans *ptrans = city_list[src].trans_;

    accessed[src] = 1; //设置出发城市为已经到达状态

    {
        std::priority_queue<std::pair<int, int,std::greater<int>>> PQ;
    }

    //查询所有的直达车, 即查询所有出发点的相邻边
    while (ptrans)
    {
        if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
        //满足三个条件
        //1. 城市不是起点
        //2. 城市没有被删除
        //3. 这条线路的交通方式满足用户要求

        {
            if (ptrans->duration_ < duration_[ptrans->tgt_])
            //注意: 有一个点到另一个点可以有多种不同的车次, 必须要对不通过的车次也加以比较
            {
                //保存当前找到的最好路径的信息
                duration_[ptrans->tgt_] = ptrans->duration_;
                trans_[ptrans->tgt_] = ptrans;
                last_[ptrans->tgt_] = ptrans->src_;
                PQ.push(pair<int, int>(ptrans->duration_, ptrans->tgt_));
            }
        }
        ptrans = ptrans->next_; //查询下一个路径
    }

    // Loop for n-1 times
    //进行n-1轮次的松弛操作
    for (int i = 1; i < size; i++)
    {
        //TODO: use priority path
        //Find the minest
        // int min = MAXDURATION - 1;
        // int min_position = -1;
        // for (int a = 0; a < size; a++)
        // {
        //     if ((!accessed[a]) && (!city_list[a].deleted_) && (ptrans->is_suitable_way(way)))
        //     {
        //         if (duration_[a] < min)
        //         {
        //             min = duration_[a];
        //             min_position = a;
        //         }
        //     }
        // }
        while ((!PQ.empty()) && accessed[PQ.top().second])
        {
            PQ.pop();
        } //当优先队列中弹出的项不符合要求时,将其舍弃
        if (!PQ.empty())
        {
            min_position = PQ.top().second; //确定当前轮生成的最短路径
            PQ.pop();                       //弹出当前最短路径, 不在参加比较
        }
        else
        // if (min_position == -1)
        {
            //There is no other path
            break;
        }
        accessed[min_position] = 1;
        //标记这个城市的最短路径已经求得

        //Relaxation
        //进行一轮松弛操作
        ptrans = city_list[min_position].trans_;

        while (ptrans)
        {
            if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
            {
                if ((ptrans->duration_ + duration_[min_position] + (ptrans->time_leave_ - ptrans[min_position].time_arrive_)) < duration_[ptrans->tgt_]) //considered the time used for transfer
                {
                    //松弛操作的说明参见伪代码
                    //注意: 这里对于时间的操作考虑到了换乘等待时间
                    duration_[ptrans->tgt_] = ptrans->duration_ + duration_[min_position];
                    trans_[ptrans->tgt_] = ptrans;
                    last_[ptrans->tgt_] = ptrans->src_;
                    //将新的较短距离加入优先队列
                    PQ.push(pair<int, int>(duration_[ptrans->tgt_], ptrans->tgt_));
                }
            }
            ptrans = ptrans->next_;
        }
    }
    //到这里, 最短路径(如果存在)已经生成完成.
}

#endif

int Dijkstra::fastest_advanced()
{
    //TODO: have bug: can only be used for the same day flight/train
    //The 1st step;
    Time* access_time=new Time[size];
    access_time[src] = time_now();
    class Trans *ptrans = city_list[src].trans_;

    while (ptrans)
    {
        if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
        {
            if(ptrans->duration_<duration_[ptrans->tgt_])
            {
                duration_[ptrans->tgt_] = ptrans->duration_;
                trans_[ptrans->tgt_] = ptrans;
                last_[ptrans->tgt_] = ptrans->src_;
            }

        }
        ptrans = ptrans->next_;
    }

    accessed[src] = 1;

    // Loop for n-1 times
    for (int i = 1; i < size; i++)
    {
        //TODO: use priority path
        //Find the minest
        int min = MAXDURATION - 1;
        int min_position = -1;
        for (int a = 0; a < size; a++)
        {
            if ((!accessed[a]) && (!city_list[a].deleted_) && (ptrans->is_suitable_way(way)))
            {
                if (duration_[a] < min)
                {
                    min = duration_[a];
                    min_position = a;
                }
            }
        }
        if (min_position == -1)
        {
            //There is no other path
            break;
        }
        accessed[min_position] = 1;

        //Relaxation
        ptrans = city_list[min_position].trans_;

        while (ptrans)
        {
            if ((!accessed[ptrans->tgt_]) && (!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
            {
                if ((ptrans->duration_ + duration_[min_position] + (ptrans->time_leave_ - ptrans[min_position].time_arrive_)) < duration_[ptrans->tgt_]) //considered the time used for transfer
                {
                    duration_[ptrans->tgt_] = ptrans->duration_ + duration_[min_position];
                    trans_[ptrans->tgt_] = ptrans;
                    last_[ptrans->tgt_] = ptrans->src_;
                }
            }
            ptrans = ptrans->next_;
        }
    }
}



int Dijkstra::coziest()
{
    //use just simple flood algorithm
    for (int i = 0; i < size; i++)
    {
        accessed[i] = 0;
    }
    accessed[src] = 1;
    //for each loop, find all the city around;
    //use cost_ to save total cost
    //use duration_ to save total duration
    //use switch_ to save the time for switch
    class Trans *ptrans;

    for (int i = 0; i < (size - 1); i++)
    {
        for (int a = 0; a < size; a++)
        {
            if (accessed[a] && (!city_list[a].deleted_))
            {
                ptrans = city_list[a].trans_;
                while (ptrans)
                {

                    if ((!city_list[ptrans->tgt_].deleted_) && (ptrans->is_suitable_way(way)))
                    {
                        if ((!accessed[ptrans->tgt_]))
                        //mark as reachable
                        {
                            accessed[ptrans->tgt_] = 1;
                            switch_[ptrans->tgt_] = i;
                            last_[ptrans->tgt_] = a;
                            trans_[ptrans->tgt_] = ptrans;
                            duration_[ptrans->tgt_] = duration_[a] + ptrans->duration_ + ((accessed[a]&&(a!=src))?(ptrans->time_leave_ - trans_[a]->time_arrive_):0);
                            cost_[ptrans->tgt_] = cost_[ptrans->tgt_] + ptrans->cost_;
                        }
                        else
                        {
                            if (switch_[ptrans->tgt_] == i) //triggered in the same level
                            {
                                // pick better
                                // TODO
                                // 1. Print the fastest path
                                // 2. Print the cheapest path
                                switch (mode)
                                {
                                case 1:
                                    // 1. Print the fastest path
                                    if (duration_[ptrans->tgt_] > duration_[a] + ptrans->duration_ + (accessed[a]&&(a!=src))?(ptrans->time_leave_ - trans_[a]->time_arrive_):0)
                                    {
                                        accessed[ptrans->tgt_] = 1;
                                        switch_[ptrans->tgt_] = i;
                                        last_[ptrans->tgt_] = a;
                                        trans_[ptrans->tgt_] = ptrans;
                                        duration_[ptrans->tgt_] = duration_[a] + ptrans->duration_ + (accessed[a]&&(a!=src))?(ptrans->time_leave_ - trans_[a]->time_arrive_):0;
                                        cost_[ptrans->tgt_] = cost_[ptrans->tgt_] + ptrans->cost_;
                                    }
                                    break;
                                case 2:
                                    // 2. Print the cheapest path
                                    if (cost_[ptrans->tgt_] >( cost_[a] + ptrans->cost_ ))
                                    {
                                        accessed[ptrans->tgt_] = 1;
                                        switch_[ptrans->tgt_] = i;
                                        last_[ptrans->tgt_] = a;
                                        trans_[ptrans->tgt_] = ptrans;
                                        duration_[ptrans->tgt_] = duration_[a] + ptrans->duration_ + ((accessed[a]&&(a!=src))?(ptrans->time_leave_ - trans_[a]->time_arrive_):0);
                                        cost_[ptrans->tgt_] = cost_[ptrans->tgt_] + ptrans->cost_;
                                    }
                                    break;
                                }
                                // last_[ptrans->tgt_] = a;
                                // trans_[ptrans->tgt_] = ptrans;
                                // duration_[ptrans->tgt_] = duration_[a] + ptrans->duration_ + (ptrans->time_leave_ - trans_[a]->time_arrive_);
                                // cost_[ptrans->tgt_] = cost_[ptrans->tgt_] + ptrans->cost_;
                            }
                        }
                    }
                    ptrans = ptrans->next_;
                }
            }
        }
        if (accessed[tgt])
        {
            //Path founded
            break;
        }
    }
    return 0;
}

int Dijkstra::show_result()
{
    cout << "-------------------------------------" << endl
         << "Your path is designed as following:" << endl;
    if (need_coziest == 2)
    {
        cout << "Least switch is required." << endl;
        // if (switch_[tgt] == MAXSWITCH)
        if (accessed[tgt] == 0)
        {
            cout << "Such path does not exist" << endl;
            return -1;
        }
        else
        {
            cout << "Times for switching:" << (switch_[tgt]) << endl;
        }
    }

    if (mode == 1)
    {
        //fast
        // fastest();
        cout << "Least duration is required." << endl;
        // if(duration_[tgt]>(MAXDURATION-1))
        if (accessed[tgt] == 0)
        {
            cout << "Such path does not exist" << endl;
            return -1;
        }
        cout << "Total time duration:" << duration_[tgt] << endl;
    }
    else
    {
        //cheapest
        // cheapest();
        cout << "Least cost is required." << endl;
        // if (duration_[tgt] > (MAXDURATION - 1))
        if (accessed[tgt] == 0)
        {
            cout << "Such path does not exist" << endl;
            return -1;
        }
        cout << "Total cost:" << cost_[tgt] << endl;
    }

    //use stack to reverse output
    stack<class Trans *> S;

    int now = tgt;

    while (now != src)
    {
        S.push(trans_[now]);
        now = last_[now];
    }

    //output S
    int duration_sum = 0;
    double cost_sum = 0;
    int switch_sum = -1;
    Time last_arrive;

    cost_sum += S.top()->cost_;
    switch_sum++;
    duration_sum += S.top()->duration_;
    last_arrive = S.top()->time_arrive_;
    show_path(S.top());
    S.pop();
    while (!S.empty())
    {
        duration_sum += (S.top()->time_leave_ - last_arrive);
        cost_sum += S.top()->cost_;
        switch_sum++;
        duration_sum += S.top()->duration_;
        last_arrive = S.top()->time_arrive_;
        show_path(S.top());
        S.pop();
    }
    //endl
    cout << "------------------------------" << endl
         << "Duration_sum is:" << duration_sum << endl
         << "Cost_sum is:" << cost_sum << endl
         << "Switch_sum is:" << switch_sum << endl
         << "================================" << endl;
    return 0;
}

int Dijkstra::interactive_lookup()
{
//TODO

//Choose mode
re_input1:
    cout << "Please choose the mode you need:" << endl
         << "1. Print the fastest path" << endl
         << "2. Print the cheapest path" << endl
         << "0. Return to upper level" << endl
         << "Type in your choice here:";
    cin >> mode;
    switch (mode)
    {
    case 1:
        break;
    case 2:
        break;
    case 0:
        return 0;
    default:
        cout << "Invalid input, please input again:" << endl;
        goto re_input1;
    }

//Choose if the less transfer is needed
re_input2:
    cout << "Please choose if you need the less transfer time:" << endl
         << "1. No" << endl
         << "2. Yes" << endl
         << "0. Return to upper level" << endl
         << "Type in your choice here:";
    cin >> need_coziest;
    switch (need_coziest)
    {
    case 1:
        break;
    case 2:
        break;
    case 0:
        goto re_input1;
    default:
        cout << "Invalid input, please input again:" << endl;
        goto re_input2;
    }

//Input src
re_src:
    cout << "Please input the city you are in:";
    cin >> src_s;
    src = hash_city(src_s);
    if (src == -1)
    {
        cout << "Such a city does not exist in the train/flight table" << endl;
        goto re_src;
    }

//Input destination
re_tgt:
    cout << "Please input the city you want to go to:";
    cin >> tgt_s;
    tgt = hash_city(tgt_s);
    if (tgt == -1)
    {
        cout << "Such a city does not exist in the train/flight table" << endl;
        goto re_tgt;
    }
    if (tgt == src)
    {
        cout << "You must be kidding me......, just go there on foot, please~" << endl;
        goto re_tgt;
    }

//Input way of transportation
//Choose if the less transfer is needed
re_way:
    cout << "Please choose the way you want to travel:" << endl
         << "1. Train only" << endl
         << "2. Plane only" << endl
         << "3. Train & Plane" << endl
         << "0. Return to upper level" << endl
         << "Type in your choice here:";

    cin >> way;
    switch (way)
    {
    case 1:
        break;
    case 2:
        break;
    case 3:
        break;
    case 0:
        goto re_src;
    default:
        cout << "Invalid input, please input again:" << endl;
        goto re_way;
    }

    //Call function
    if (need_coziest == 2)
    {
        coziest();//use flood algorithm to calc 
    }
    else
    {
        if (mode == 1)
        {
            //fast
            fastest();
        }
        else
        {
            //cheapest
            cheapest();
        }
    }

    //Print show_result
    show_result();
}

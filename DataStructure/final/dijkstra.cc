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

    int update_data()
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

    ~Dijkstra()
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
    int interactive_lookup();
    int show_result();

  private:
    //graph information
    int size;

    //source and destination
    int src;
    int tgt;
    string src_s;
    string tgt_s;

    //global vars for Dijkstra
    int *switch_;
    double *cost_;
    int *duration_;
    class Trans **trans_;
    int *last_;

    bool *accessed;

    //settings
    int way;
    int need_coziest;
    int mode;
};

int Dijkstra::cheapest()//选取价格最低的路线
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

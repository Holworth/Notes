#include"head.cc"

class Dijkstra
{
  public:
    Dijkstra()
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

    ~Dijkstra()
    {
        delete[] switch_;
        delete[] cost_;
        delete[] duration_;
    }

    int fastest()
    {
        //TODO
    }

    int cheapest()
    {
        //TODO
        //The 1st step;
        class Trans *ptrans = city_list[src].trans_;

        while (ptrans)
        {
            cost_[ptrans->tgt_] = ptrans->cost_;
            trans_[ptrans->tgt_] = ptrans;
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
                if ((!accessed[a]) && (!city_list[a].deleted_))
                {
                    if (cost_[a] < min)
                    {
                        min = cost_[a];
                        min_position = a;
                    }
                }
            }
            if (min == -1)
            {
                //There is no other path
                break;
            }

            //Relaxation
            ptrans = city_list[min].trans_;

            while (ptrans)
            {
                if (!accessed[ptrans->tgt_])
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

    int coziest()
    {
        //TODO
        return 0;
    }

    int show_result()
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
                cout << "Times for switching:" << switch_[tgt] << endl;
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
            cout << "Least duration is required." << endl;
            // if (duration_[tgt] > (MAXDURATION - 1))
            if (accessed[tgt] == 0)
            {
                cout << "Such path does not exist" << endl;
                return -1;
            }
            cout << "Total time duration:" << duration_[tgt] << endl;
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
        }
        //endl
        cout << "------------------------------" << endl
             << "Duration_sum is:" << duration_sum << endl
             << "Cost_sum is:" << cost_sum << endl
             << "Switch_sum is:" << switch_sum << endl
             << "================================" << endl;
        return 0;
    }

    int lookup()
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
            coziest();
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


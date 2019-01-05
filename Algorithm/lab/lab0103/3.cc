// #include<bits/stdc++>
#include <iostream>
// #include <cstdio>
#include <algorithm>
#include <vector>
#include <string>
#include <string.h>
#include <map>
#include <queue>
#include <cstring>
#include <cstdlib>

using namespace std;
#define INF 0x3f3f3f3f
#define is_outranged(x, y, w, h) (((x + w) > W) || ((y + h) > H))

int W, H, n, t;
string op;
int x, y, w, h, dx, dy;

typedef class Box
{
  public:
    int x;
    int y;
    int w;
    int h;
    bool valid;
    Box(int x, int y, int w, int h) : x(x),
                                      y(y),
                                      w(w),
                                      h(h),
                                      valid(1){};

    bool not_fit_with(int x, int y, int w, int h)
    {
        // 两个矩形的x轴上的中心距离  >  两个矩形的长度之和的一半
        // 两个矩形的y轴上的中心距离  >  两个矩形的高度之和的一半
        int x1 = this->x, y1 = this->y, x2 = this->x + this->w, y2 = this->y + this->h;
        int x3 = x, y3 = y, x4 = x + w, y4 = y + h;
        int wsum = w + this->w;
        int hsum = h + this->h;
        int xdis2 = abs((x2 + x1) - (x3 + x4));
        int ydis2 = abs((y2 + y1) - (y3 + y4));
        // cout<<xdis2<<" "<<ydis2<<" "<<wsum<<" "<<hsum<<endl;
        return !((xdis2 >= wsum) || (ydis2 >= hsum));
        //0 0 1 1 1 1
        //1 1 1 1 2 2
        //2 2 2 2
    }

    bool not_fit_with(class Box in)
    {
        return not_fit_with(in.x, in.y, in.w, in.h);
    }

    bool have_point(int x, int y)
    {
        return ((x >= this->x) && (x < (this->x + this->w)) && (y >= this->y) && (y < (this->y + this->h)));
    }
} box_t;

vector<class Box> boxs;
vector<class Box> boxs_cp;

//检查扫过的面积
int basic_move(int num, int dx, int dy) //num 是箱子的编号
{
    //dx only
    // cout<<num<<" "<<dx<<" "<<dy<<endl;
    while (dx > 0)
    {
        int x = boxs[num].x + 1, y = boxs[num].y;
        int s = boxs.size();
        {
            if (((x + boxs[num].w) > W) || ((y + boxs[num].h) > H))
            {
                return dx; //failed
            }
        }
        int res = 0;
        for (int i = 0; i < s; i++)
        {
            if ((i != num) && boxs[i].valid && boxs[i].not_fit_with(x, y, boxs[num].w, boxs[num].h))
            {
                res = basic_move(i, 1, 0);
            }
        }
        if (res) //move failed
        {
            return dx;
        }
        else
        {
            boxs[num].x = x;
            boxs[num].y = y;
        }
        dx--;
    }
    return 0; //succeed
}

int basic_move_cp(int num, int dx, int dy) //num 是箱子的编号
{
    //dx only
    // cout<<num<<" "<<dx<<" "<<dy<<endl;
    while (dx > 0)
    {
        int x = boxs_cp[num].x + 1, y = boxs_cp[num].y;
        int s = boxs_cp.size();
        {
            if (((x + boxs_cp[num].w) > W) || ((y + boxs_cp[num].h) > H))
            {
                return dx; //failed
            }
        }
        int res = 0;
        for (int i = 0; i < s; i++)
        {
            if ((i != num) && boxs_cp[i].valid && boxs_cp[i].not_fit_with(x, y, boxs_cp[num].w, boxs_cp[num].h))
            {
                res = basic_move(i, 1, 0);
            }
        }
        if (res) //move failed
        {
            return dx;
        }
        else
        {
            boxs_cp[num].x = x;
            boxs_cp[num].y = y;
        }
        dx--;
    }
    return 0; //succeed
}


int basic_move_left(int num, int dx, int dy) //num 是箱子的编号
{
    //dx only
    // cout<<num<<" "<<dx<<" "<<dy<<endl;
    while (dx > 0)
    {
        int x = boxs[num].x - 1, y = boxs[num].y;
        int s = boxs.size();
        {
            if (((x) < 0) || ((y) < 0))
            {
                return dx; //failed
            }
        }
        int res = 0;
        for (int i = 0; i < s; i++)
        {
            if ((i != num) && boxs[i].valid && boxs[i].not_fit_with(x, y, boxs[num].w, boxs[num].h))
            {
                res = basic_move_left(i, 1, 0);
            }
        }
        if (res) //move failed
        {
            return dx;
        }
        else
        {
            boxs[num].x = x;
            boxs[num].y = y;
        }
        dx--;
    }
    return 0; //succeed
}

int test_move(int num, int dx, int dy)
{
    int right=boxs_cp[num].x+dx+boxs_cp[num].w;
    if(right>W)
    {
        dx=dx-(right-W);
    }

    int s=boxs_cp.size();
    for(int i=0;i<s;i++)
    {
        if((i!=num)&&(boxs_cp[i].valid)&&(boxs_cp[i].not_fit_with(boxs_cp[num].x,boxs_cp[num].y,boxs_cp[num].w+dx,boxs_cp[num].h)))
        {
            int should_move=dx-(boxs_cp[i].x-(boxs_cp[num].x+boxs_cp[num].w));
            dx-=(should_move-test_move(i,should_move,dy));
        }
    }
    boxs_cp[num].x+=dx;
    // cout<<"boxs_cp[num].x "<<boxs_cp[num].x<<" "<<num<<endl;
    // cout<<"dx "<<dx<<endl;
    return dx;
}


int real_move(int num, int dx, int dy)
{
    int right=boxs[num].x+dx+boxs[num].w;
    if(right>W)
    {
        dx=dx-(right-W);
    }

    int s=boxs.size();
    for(int i=0;i<s;i++)
    {
        if((i!=num)&&(boxs[i].valid)&&(boxs[i].not_fit_with(boxs[num].x,boxs[num].y,boxs[num].w+dx,boxs[num].h)))
        {
            int should_move=dx-(boxs[i].x-(boxs[num].x+boxs[num].w));
            dx-=(should_move-real_move(i,should_move,dy));
        }
    }
    boxs[num].x+=dx;
    return dx;
}

int move(int num, int dx, int dy)
{
    boxs_cp.clear();
    boxs_cp.assign(boxs.begin(), boxs.end());
    int rx=test_move(num, dx, dy);
    // cout<<rx<<endl;
    real_move(num, rx, dy);
    return dx-rx;
}

int main()
{
    ios::sync_with_stdio(false);
    cin >> W >> H >> n >> t;
    int ni = 0;
    while (ni++ < n)
    {
        cin >> op;
        if (op == "OPEN")
        {
            cin >> x >> y >> w >> h;

            //check

            {
                if ((x < 0) || (y < 0) || (x + w) > (W) || (y + h) > (H))
                {
                    cout << "Command " << ni << ": OPEN - box does not fit" << endl;
                    goto end_inst;
                }
            }

            int s = boxs.size();
            for (int i = 0; i < s; i++)
            {
                if (boxs[i].valid && boxs[i].not_fit_with(x, y, w, h))
                {
                    cout << "Command " << ni << ": OPEN - box does not fit" << endl;

                    // cout<<"Command "<<ni<<": RESIZE - box does not fit"<<endl;
                    goto end_inst;
                }
            }

            boxs.push_back(Box(x, y, w, h));
        }

        if (op == "CLOSE")
        {
            cin >> x >> y;

            int s = boxs.size();
            for (int i = 0; i < s; i++)
            {
                if (boxs[i].valid && boxs[i].have_point(x, y))
                {
                    // cout<<"Command "<<ni<<": RESIZE - box does not fit"<<endl;
                    // del this box
                    // cout<<i<<" "<<boxs[i].x<<" "<<boxs[i].y<<endl;
                    boxs[i].valid = 0;
                    goto end_inst;
                }
            }
            {
                cout << "Command " << ni << ": CLOSE - no box at given position" << endl;
                continue;
            }
        }
        if (op == "RESIZE")
        {
            cin >> x >> y >> w >> h;

            //check

            int s = boxs.size();
            for (int i = 0; i < s; i++)
            {
                if (boxs[i].valid && boxs[i].have_point(x, y))
                {
                    int curx = boxs[i].x;
                    int cury = boxs[i].y;
                    // cout<<"Command "<<ni<<": OPEN - box does not fit"<<endl;
                    // cout<<"Command "<<ni<<": RESIZE - box does not fit"<<endl;
                    for (int j = 0; j < s; j++)
                    {
                        if (boxs[j].valid && (j != i) && boxs[j].not_fit_with(curx, cury, w, h))
                        {
                            // if ((x != boxs[j].x) && (y != boxs[j].y))
                            // {
                            cout << "Command " << ni << ": RESIZE - box does not fit" << endl;
                            // cout
                            //     << boxs[i].x << " "
                            //     << boxs[i].y << " "
                            //     << boxs[i].w << " "
                            //     << boxs[i].h << " "
                            //     << x << " "
                            //     << y << " "
                            //     << w << " "
                            //     << h << " " << endl;
                            goto end_inst;
                            // }
                        }
                    }
                    //succeed
                    {
                        //TEST IF OUT OF RANGE
                        if (((boxs[i].x + w) > W) || ((boxs[i].y + h) > H))
                        { //failed
                            cout << "Command " << ni << ": RESIZE - box does not fit" << endl;
                            goto end_inst;
                        }
                    }
                    boxs[i].w = w;
                    boxs[i].h = h;
                    goto end_inst;
                }
            }
            cout << "Command " << ni << ": RESIZE - no box at given position" << endl;
            continue;
        }
        if (op == "MOVE")
        {
            cin >> x >> y >> dx >> dy;
            int s = boxs.size();
            for (int i = 0; i < s; i++)
            {
                if (boxs[i].valid && boxs[i].have_point(x, y))
                {
                    // cout<<"Command "<<ni<<": RESIZE - box does not fit"<<endl;
                    // del this box
                    int res;
                    if (dx >= 0)
                    {
                        // boxs_cp.clear();
                        // boxs_cp.assign(boxs.begin(), boxs.end());
                        // basic_move_cp(i, dx, dy);
                        res=move(i,dx,dy);
                        // {
                        //     int s=boxs_cp.size();
                        //     for(int i=0;i<s;i++)
                        //     {
                        //         if(
                        //             (boxs[i].x!=boxs_cp[i].x)||
                        //             (boxs[i].y!=boxs_cp[i].y)||
                        //             (boxs[i].w!=boxs_cp[i].w)||
                        //             (boxs[i].h!=boxs_cp[i].h)
                        //             )
                        //         {
                        //             cout<<"new: "<<
                        //                 boxs[i].x<<" "<<
                        //                 boxs[i].y<<" "<<
                        //                 boxs[i].w<<" "<<
                        //                 boxs[i].h<<" "<<endl;
                        //             cout<<"old: "<<
                        //                 boxs_cp[i].x<<" "<<
                        //                 boxs_cp[i].y<<" "<<
                        //                 boxs_cp[i].w<<" "<<
                        //                 boxs_cp[i].h<<" "<<endl;
                        //         }
                        //     }
                        // }
                        if (res == 0)
                            goto end_inst;
                        else
                        {
                            cout << "Command " << ni << ": MOVE - moved " << dx - res << " instead of " << dx << endl;
                            goto end_inst;
                        }
                    }
                    else
                    {
                        res = basic_move_left(i, -dx, dy);
                        if (res == 0)
                            goto end_inst;
                        else
                        {
                            cout << "Command " << ni << ": MOVE - moved " << -dx - res << " instead of " << dx << endl;
                            goto end_inst;
                        }
                    }
                }
            }
            cout << "Command " << ni << ": MOVE - no box at given position" << endl;
            goto end_inst;
        }
        // newbox();

    end_inst:
        1;
    }

    int s = boxs.size();
    int valid_box = 0;
    for (int i = 0; i < s; i++)
    {
        if (boxs[i].valid)
        {
            valid_box++;
        }
    }
    cout << valid_box << " box(es):" << endl;
    for (int i = 0; i < s; i++)
    {
        if (boxs[i].valid)
        {
            cout
                << boxs[i].x << " "
                << boxs[i].y << " "
                << boxs[i].w << " "
                << boxs[i].h << " "
                << endl;
        }
    }
    return 0;
}


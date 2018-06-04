#include "graph.cc"

// 7.14, 7.15, 7.22, 7.25, 7.27, 7.36, 7.38, 7.42
using namespace std;

// 7.14 编写算法，由依次输入的顶点数目、弧的数目、各顶点的信息和各条弧的信息建立有向图的邻接表。

GraphAdjlist<int> *
Algo7_14()
{
    int vertex;
    int edge;
    cin >> vertex >> edge;
    auto result = new GraphAdjlist<int>(vertex);
    while (edge-- > 0)
    {
        int tail, head, data;
        cin >> tail >> head >> data;
        result->setedge(tail, head, data);
    }
    result->print();
    return result;
}

// 7.15 试在邻接矩阵存储结构上实现图的基本操作 : InsertVex(G, v) ，InsertArc(G, v, w) ，DeleteVex(G, v) 和DeleteArc(G, v, w)。
// 没有较好的办法, 暴力重构图
// Graph的相关函数已经用虚函数定义, 使用时直接对GraphAdjlist的指针使用即可自动调用对应的函数

template <class T>
Graph<T> *InsertVex(Graph<T> *G, int v)
{
    //如果需要指定节点名则建立一个节点名称-节点顺序编号的一一映射. 使用map或array
    int s = G->size();
    Graph<T> *result(G->size() + 1);
    for (int a = 0; a < s; a++)
    {
        for (int b = 0; b < s; b++)
        {
            result->setedge(a, b, G->getedge(a, b));
        }
        result->erase(s + 1, a);
        result->erase(a, s + 1);
    }
}

template <class T>
Graph<T> *DeleteVex(Graph<T> *G, int v)
{
    int s = G->size();
    Graph<T> *result(s - 1);
    for (int a = 0; a < s; a++)
    {
        for (int b = 0; b < s; b++)
        {
            auto a1 = a;
            auto b1 = b;
            if (a > v)
            {
                a1--;
            }
            if (b > v)
            {
                b1--;
            }
            result->setedge(a1, b1, G->getedge(a1, b1));
        }
    }
}

template <class T>
Graph<T> *InsertArc(Graph<T> *G, int v, int w)
{
    G->setedge(v, w, 0);
    return G;
}

template <class T>
void DeleteArc(Graph<T> *G, int v, int w)
{
    G->erase(v, w);
}

// 7.22 试基于图的深度优先搜索策略写一算法，判别以邻接表方式存储的有向图中是否存在由顶点vi到顶点vj的路径(i≠j)。注意：算法中涉及的图的基本操作必须在此存储结构上实现。

template <class T>
bool havepath(GraphAdjlist<T> *G, int src, int dist)
{
    bool access[G->size()];
    for (auto i : access)
    {
        i = false;
    }
    auto s = G->size();
    std::stack<int> S;
    S.push(src);
    while (!S.empty())
    {
        if (access[S.top()])
        {
            S.pop();
            continue;
        }
        if (S.top() == dist)
            return true;
        access[S.top()] = true;
        S.push(G->vertex_around(S.top()));
        S.pop();
    }
    return false;
}

// 7.25 假设对有向图中n个顶点进行自然编号，并以三个数组s [1…max], fst[1…n] 和lst[1…n] 表示之。
// 其中数组s存放每个顶点的后继顶点的信息，第i个顶点的后继顶点存放在s中下标从fst[i] 起到lst[i] 的分量中(i = 1, 2,…, n)。
// 若fst[i] > lst[i] ，则第i个顶点无后继顶点。试编写判别该有向图中是否存在回路的算法。

// 直接拓扑排序

bool Algo7_25(int* s,int* fst,int* lst, int n, int i)
{
    int cnt = n;
    bool find[n];
    while (n > 0)
    {
        for( auto i:find)
            i = 0;
        for (int i = 0; i <= lst[n-1];i++)
        {
            if(s[i]!=-1)
            find[s[i]] = 1;
        }
        bool end = 1;
        for (int i = 0; i < n; i++)
        {
            if(!find[i])
            {
                cnt--;
                end = 0;
                for (int b = fst[i]; b <= lst[i]; b++)
                {
                    s[b] = -1;
                }
            }
        }
        if(end)
            return true;
    }
    return false;
}

// 7.27 采用邻接表存储结构，编写一个判别无向图中任意给定的两个顶点之间是否存在一条长度为k的简单路径的算法（一条路径为简单路径指的是其顶点序列中不含有重现的顶点)。
// DFS: 当长度超过k时终止此分支

//G should be GraphAdjlist*

template <class T>
int DFShavepathk(Graph<T> *G, int src, int dst, T k, bool *access)
{
    if (k == 0)
    {
        std::cout << "Find path k!" << std::endl;
        return 0;
    }
    if (k < 0)
        return -1; //this DFS baranch failed.
    if (access[src])
        return -1; //This point has been accessed in this DFS branch.
    access[src] = true;
    auto around = G->vertex_around();
    while (!around.empty())
    {
        if (access[around.back()])
            continue;
        auto t = G->getedge(src, around.back());
        if (t.exist)
        {
            DFShavepathk(G, around.back(), dst, k - t.data, access);
        }
    }
}

template <class T>
bool havepathk(Graph<T> *G, int src, int dst, T k)
{
    bool access[G->size()];
    DFShavepathk(G.src.dst, k, access);
}

// 7.36 在图的邻接表存储结构中，为每个顶点增加一个MPL域。试写一算法，求有向无环图G的每个顶点出发的最长路径的长度，并存入其MPL域。请给出算法的时间复杂度。

// 不想改动库里的结构了, 在外部附加一个大小相同的数组.
// O(n3) Floyd算法
template <class T>
T *FloydMax(Graph<T> *G)
{
    T D[G->size()][G->size()];
    bool inf[G->size()][G->size()];
    for (int a = 0; a < G->size(); a++)
    {
        for (int b = 0; b < G->size(); b++)
        {
            auto t = G->edge(a, b);
            if (t.exist)
            {
                inf[a][b] = false;
                D[a][b] = t.data;
            }
            else
            {
                inf[a][b] = true;
            }
        }
    }
    for (int k = 0; k < G->size(); k++)
    {
        for (int a = 0; a < G->size(); a++)
        {
            for (int b = 0; b < G->size(); b++)
            {
                if (!inf[a][k] && !inf[k][b])
                {
                    auto l = D[a][k] + D[k][b];
                    if (l > D[a][b] || inf[a][b])
                    {
                        D[a][b] = l;
                        inf[a][b] = false;
                    }
                }
            }
        }
    }
    auto result = new T[G->size()];
    for (int i = 0; i < G->size(); i++)
    {
        result[i] = 0;
        for (int p = 0; p < G->size(); p++)
        {
            if (!inf[i][p] && D[i][p] > result[i])
            {
                result[i] = D[i][p];
            }
        }
    }
    return result;
}

// 7.38 一个四则运算算术表达式以有向无环图的邻接表方式存储，每个操作数原子都由单个字母表示。写一个算法输出其逆波兰表达式。

// 后序DFS, 可能有公用子树
int DFS7_38(Graph<char> *G, int root)
{
    auto t= G->vertex_around(root);
    while(!t.empty())
    {
        DFS7_38(G,t.back());
        t.pop_back();
    }
    std::cout << G->getvertex(root);
}

int Algo7_38(Graph<char> *G, int root)
{
    DFS7_38(G,root);
}

// 7.42 以邻接表作存储结构实现求从源点到其余各顶点的最短路径的Dijkstra算法。

template <class T>
struct result7_42
{
    T distance;
    bool inf;
};

template <class T>
void Algo7_42(GraphAdjlist<T> *G, int src)
{
    //没有优化, 直接用了通用算法, 凑合看吧
    //遍历周边节点部分可以利用Adjlist的性质优化
    int s = G->size();
    bool inf[s];
    bool access[s];
    int father[s];
    T distance[s];
    for (int b = 0; b < s; b++)
    {
        access[b] = 0;
        father[b] = -1;
        auto t = G->edge(src, b);
        if (t.exist)
        {
            inf[b] = false;
            distance[b] = t.data;
            father[b] = src;
        }
        else
        {
            inf[b] = true;
        }
    }
    access[src] = 1;
    int last = src;
    for (int a = 0; a < s - 1; a++)
    {
        bool mininf = true;
        T min;
        int minindex = -1;
        for (int b = 0; b < s; b++)
        {
            if (!access[b])
            {
                if (!inf[b])
                {
                    if (mininf)
                    {
                        mininf = false;
                        minindex = b;
                        min = distance[b];
                    }
                    else
                    {
                        if (distance[b] < min)
                        {
                            minindex = b;
                            min = distance[b];
                        }
                    }
                }
            }
        }
        last = minindex;
        access[last] = true;
        for (int b = 0; b < s; b++)
        {
            if (!access[b])
            {
                auto t = G->edge(last, b);
                if (t.exist)
                {
                    auto m = distance[last] + t.data;
                    if (m < distance[b])
                    {
                        distance[b] = m;
                        father[b] = last;
                    }
                }
            }
        } //update finished
    }
    auto r=new result7_42<T>[G->size()];
    for (int i = 0; i<G->size();i++)
    {
        r[i].distance = distance[i];
        r[i].inf = inf[i];
    }
    return r;
}

int main()
{

    //7-14
    L;
    cout << "7-14" << endl;
    auto G1 = Algo7_14();
    cout << G1->getedge(0, 1).exist << endl;
    cout << G1->getedge(0, 1).data << endl;
}
//OO_nvertexDT_Code Project
//https://github.com/L-F-Z/ADT_Code
//https://github.com/AugustusWillisWang/Notes/tree/master/DataStructure/ooadt
//Developed by AugustusWillisWang

#include <iostream>
#include <exception>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <vector>
#include <utility>

#include <string.h>
#include <stdio.h>

#include "adt.h"
#include "dbg.h"

// #define MAGIC_MAX 23333

//图模板定义----------------------------------------------------------------

template <class T>
struct GetedgeResult
{
    T data;
    bool exist;
}; //use auto to simplify your code;

#include <vector>

// template <class T>
struct TraverseNode
{
    int vertex;
    std::vector<std::pair<int, int>> edge;
};

template <class T>
class Graph
{
    //父类, 提供图所用到的各种接口
    //Do remember that T should only be typename of number. T is used as the value of each vertex and each edge;

  public:
    Graph()
    {
        std::cout << "Init graph: " << this << std::endl;
    }
    ~Graph()
    {
        std::cout << "Destruct graph: " << this << std::endl;
    }

    virtual GetedgeResult<T> getedge(int tail, int head) //查找某条边的权值
    {
        std::cout << "Called pure virtual func getedge." << std::endl;
        throw("Called pure virtual func getedge.");
    }
    virtual GetedgeResult<T> edge(int tail, int head) //查找某条边的权值
    {
        return getedge(tail, head);
    }

    virtual int setedge(int tail, int head, T val) //写入某条边的权值
    {
        std::cout << "Called pure virtual func setedge." << std::endl;
        throw("Called pure virtual func setedge.");
    }

    virtual bool haveedge(int vertex) //查找某个顶点是否存在出边
    {
        std::cout << "Called pure virtual func haveedge." << std::endl;
        throw("Called pure virtual func haveedge.");
    }
    virtual bool existedge(int tail, int head) //查找某个顶点是否存在出边
    {
        std::cout << "Called pure virtual func existedge." << std::endl;
        throw("Called pure virtual func existedge.");
    }

    virtual int degree(int vertex)
    {
        std::cout << "Degree func undefined." << std::endl;
    }
    virtual int indegree(int vertex)
    {
        std::cout << "In degree func undefined." << std::endl;
    }
    virtual int outdegree(int vertex)
    {
        std::cout << "Out degree func undefined." << std::endl;
    }

    virtual int vertex()
    {
        std::cout << "Vertex func undefined." << std::endl;
    }
    virtual int size()
    {
        return vertex();
    }

    virtual std::vector<std::pair<int, int>> alledge()
    {
        std::cout << "alledge func undefined." << std::endl;
        throw("alledge func undefined.");
    }

    virtual std::vector<std::pair<int, int>> getedge_around(int vertex)
    {
        std::cout << "Getedge_around func undefined." << std::endl;
        throw("Getedge_around func undefined.");
    }

    virtual std::vector<int> vertex_around(int vertex)
    {
        std::cout << "Vertex_around func undefined." << std::endl;
        throw("Vertex_around func undefined.");
    }

    virtual int erase(int tail, int head)
    {
        std::cout << "erase func undefined." << std::endl;
        throw("erase func undefined.");
    }

    virtual int erase(int vertex)
    {
        std::cout << "erase func undefined." << std::endl;
        throw("erase func undefined.");
    }

    virtual int print()
    {
        std::cout << "No print func assigned, use print array as default." << std::endl;
        std::cout << "Different row means diff tail, while diff col means diff heads." << std::endl;
        std::cout << "-----------------------" << std::endl;
        std::cout << "Graph: " << this << std::endl;

        int t = this->vertex();
        for (int a = 0; a < t; a++)
        {
            for (int b = 0; b < t; b++)
            {
                auto p = getedge(a, b);
                if (!p.exist)
                {
                    std::cout << "x"
                              << "\t";
                }
                else
                {
                    std::cout << p.data
                              << "\t";
                }
            }
            std::cout << std::endl;
        }
    }

    virtual T getvertex(int vertex)
    {
        std::cout << "getvertex func undefined." << std::endl;
        throw("getvertex func undefined.");
    }

    // friend bool
    // operator<(const std::pair<int, int> e1, const std::pair<int, int> e2)
    // {
    //     auto le1 = edge(e1.first, e1.second);
    //     auto le2 = edge(e2.first, e2.second);
    //     if (!le1.exist)
    //     {
    //         return false;
    //     }
    //     if (!le2.exist)
    //     {
    //         return true;
    //     }

    //     return le1.data < le2.data;
    // }
    // int nvertex_;
};

//有向图的邻接矩阵表示
template <class T>
class GraphArray : public Graph<T>
{
  public:
    GraphArray(int vertex)
    {
        int i = vertex * vertex;
        data_ = new T[i];
        mark_ = new int[i];
        exist_ = new bool[i];
        nvertex_ = vertex;
        while (i-- > 0)
        {
            mark_[i] = 0;
            exist_[i] = false;
        }
    }
    ~GraphArray()
    {
        delete[] data_;
        delete[] mark_;
        delete[] exist_;
    }

    GraphArray<T>(const GraphArray<T> &src)
    {
        nvertex_ = src.nvertex_;
        for (int i = 0; i < nvertex_ * nvertex_; i++)
        {
            *(data_ + i) = *(src.data_ + i);
            *(mark_ + i) = *(src.mark_ + i);
            *(exist_ + i) = *(src.exist_ + i);
        }
    }

    struct GetedgeResult<T> getedge(int tail, int head)
    {
        struct GetedgeResult<T> result;
        result.data = *(data_ + tail * nvertex_ + head);
        result.exist = *(exist_ + tail * nvertex_ + head);
        return result;
    }

    int
    setedge(int tail, int head, T value)
    {
        *(data_ + tail * nvertex_ + head) = value;
        *(exist_ + tail * nvertex_ + head) = true;
    }

    bool existedge(int tail, int head)
    {
        return *(exist_ + tail * nvertex_ + head);
    }

    int setedgemark(int tail, int head, int value)
    {
        *(mark_ + tail * nvertex_ + head) = value;
    }

    int setedgeexist(int tail, int head, bool value)
    {
        *(exist_ + tail * nvertex_ + head) = value;
    }

    bool haveedge(int vertex)
    {
        bool result = false;
        for (int i = 0; i < nvertex_; i++)
        {
            if (*(exist_ + vertex * nvertex_ + i))
            {
                result = true;
                break;
            }
        }
        return result;
    }

    int vertex()
    {
        return nvertex_;
    }
    int size()
    {
        return nvertex_;
    }

    virtual int indegree(int vertex)
    {
        int res = 0;
        for (int i = 0; i < nvertex_; i++)
        {
            if (existedge(i, vertex))
                res++;
        }
        return res;
    }
    virtual int outdegree(int vertex)
    {
        int res = 0;
        for (int i = 0; i < nvertex_; i++)
        {
            if (existedge(vertex, i))
                res++;
        }
        return res;
    }

    int degree(int vertex)
    {
        return indegree(vertex) + outdegree(vertex);
    }

    std::vector<std::pair<int, int>> getedge_around(int vertex)
    {
        std::vector<std::pair<int, int>> result;
        std::pair<int, int> p;
        for (int i = 0; i < nvertex_; i++)
        {
            if (*(exist_ + vertex * nvertex_ + i))
            {
                p.first = vertex;
                p.second = i;
                result.push_back(p);
            }
        }
        return result;
    }

    virtual std::vector<int> vertex_around(int vertex)
    {
        std::vector<int> result;
        for (int i = 0; i < nvertex_; i++)
        {
            if (*(exist_ + vertex * nvertex_ + i))
            {
                result.push_back(i);
            }
        }
        return result;
    }

    int zero()
    {
        for (int i = 0; i < nvertex_ * nvertex_; i++)
        {
            *(data_ + i) = 0;
            *(mark_ + i) = 0;
        }
    }

    int init()
    {
        for (int i = 0; i < nvertex_ * nvertex_; i++)
        {
            *(exist_ + i) = false;
        }
    }

    virtual std::vector<std::pair<int, int>> alledge()
    {
        std::vector<std::pair<int, int>> result;
        for (int a = 0; a < size(); a++)
        {
            for (int b = 0; b < size(); b++)
            {
                auto t = getedge(a, b);
                if (t.exist)
                {
                    result.push_back(std::pair<int, int>(a, b));
                }
            }
        }
        return result;
    }

    virtual int erase(int tail, int head)
    {
        *(exist_ + tail * nvertex_ + head) = false;
    }

    virtual int erase(int vertex)
    {
        std::cout << "erase vertex cannot be used for array graph." << std::endl;
        throw("erase vertex cannot be used for array graph.");
    }

    T getvertex(int vertex)
    {
        return data_[vertex];
    }

    int nvertex_;
    T *data_;
    int *mark_;
    bool *exist_;
};

//有向图的邻接表表示--------------------------------------------------------------------
template <class T>
struct ArcAdjlist
{
    int head;
    int tail;
    struct ArcAdjlist *nextarc;
    int mark;
    T data;
};

template <class T>
struct PointAdjlist
{
    T data;
    int mark;
    struct ArcAdjlist<T> *firstarc;
};

template <class T>
class GraphAdjlist : public Graph<T>
{
  public:
    GraphAdjlist(int nvertix)
    {
        data_ = new struct PointAdjlist<T>[nvertix];
        nvertex_ = nvertix;
        while (nvertix-- > 0)
        {
            data_[nvertix].firstarc = 0;
            data_[nvertix].data = 0;
            data_[nvertix].mark = 0;
        }
    }
    ~GraphAdjlist()
    {
        delete[] data_;
    }

    int setedge(int tail, int head, T val)
    {
        struct ArcAdjlist<T> *now = new ArcAdjlist<T>;
        now->head = head;
        now->tail = tail;
        now->data = val;
        now->mark = 0;
        now->nextarc = data_[tail].firstarc;
        data_[tail].firstarc = now;
    }

    struct GetedgeResult<T> getedge(int tail, int head)
    {
        struct GetedgeResult<T> result;
        struct ArcAdjlist<T> *now = data_[tail].firstarc;
        while (now && now->head != head)
            now = now->nextarc;
        if (now)
        {
            result.data = now->data;
            result.exist = true;
            return result;
        };
        {
            result.exist = false;
            return result;
        }
    }

    bool
    haveedge(int vertex)
    {
        return data_[vertex].firstarc != 0;
    }

    int vertex()
    {
        return nvertex_;
    }

    T getvertex(int vertex)
    {
        return data_[vertex].data ;
    }

    int nvertex_;
    struct PointAdjlist<T> *data_;
};

//有向图的十字链表表示

template <class T>
struct ArcOrthgonal
{
    int head;
    int tail;
    struct ArcOrthgonal *headarc;
    struct ArcOrthgonal *tailarc;
    int mark;
    T data;
};

template <class T>
struct PointOrthogonal
{
    T data;
    int mark;
    struct ArcOrthgonal<T> *firsthead;
    struct ArcOrthgonal<T> *firsttail;
};

template <class T>
class GraphOrthgonal : public Graph<T>
{
  public:
    GraphOrthgonal(int nvertix)
    {
        data_ = new struct PointOrthogonal<T>[nvertix];
        nvertex_ = nvertix;
        while (nvertix-- > 0)
        {
            data_[nvertix].firsthead = 0;
            data_[nvertix].firsttail = 0;
            data_[nvertix].data = 0;
            data_[nvertix].mark = 0;
        }
    }
    ~GraphOrthgonal()
    {
        delete[] data_;
    }

    int setedge(int tail, int head, T val)
    {
        //是否允许相同的边被重复设置?
        auto p = new struct ArcOrthgonal<T>;
        p->data = val;
        p->tail = tail;
        p->head = head;
        p->mark = 0;
        p->headarc = data_[head].firsthead;
        p->tailarc = data_[tail].firsttail;

        data_[tail].firsttail = p;
        data_[head].firsthead = p;
    }

    struct GetedgeResult<T> getedge(int tail, int head)
    {
        struct GetedgeResult<T> result;
        result.exist = true;

        if (auto p = data_[tail].firsttail)
        {
            while (p && p->head != head)
            {
                p = p->tailarc;
            }
            if (p)
            {
                result.data = p->data;
                return result;
            }
            {
                result.exist = false;
                return result;
            }
        }
        {
            result.exist = false;
            return result;
        }
    }

    struct GetedgeResult<T>
    edge(int tail, int head)
    {
        return getedge(tail, head);
    }

    bool
    haveedge(int vertex)
    {
        return data_[vertex].firsttail != 0;
    }

    int vertex()
    {
        return nvertex_;
    }

    T getvertex(int vertex)
    {
        return data_[vertex].data;
    }

    int nvertex_;
    struct PointOrthogonal<T> *data_;
};

//邻接多重表无向图
//感觉这个定义就很睿智

template <class T>
struct ArcAdjmullist
{
    int head;
    int tail;
    struct ArcAdjmullist *headarc;
    struct ArcAdjmullist *tailarc;
    int mark;
    T data;
};

template <class T>
struct PointAdjmullist
{
    T data;
    int mark;
    struct ArcAdjmullist<T> *firstarc;
};

template <class T>
class GraphAdjmullist : public Graph<T>
{
  public:
    GraphAdjmullist(int nvertix)
    {
        data_ = new struct PointAdjmullist<T>[nvertix];
        nvertex_ = nvertix;
        while (nvertix-- > 0)
        {
            data_[nvertix].firstarc = 0;
            data_[nvertix].data = 0;
            data_[nvertix].mark = 0;
        }
    }
    ~GraphAdjmullist()
    {
        delete[] data_;
    }
    int setedge(int tail, int head, T val)
    {
        auto p = new ArcAdjmullist<T>;
        p->tail = tail;
        p->head = head;
        p->data = val;
        p->mark = 0;
        p->headarc = data_[head].firstarc;
        p->tailarc = data_[tail].firstarc;
        data_[head].firstarc = p;
        data_[tail].firstarc = p;
    }

    struct GetedgeResult<T> getedge(int tail, int head)
    {
        struct GetedgeResult<T> result;
        struct ArcAdjmullist<T> *now = data_[tail].firstarc;
        while (now)
        {

            if (now->tail == tail)
            {
                if (now->head == head)
                    break;
                now = now->headarc;
            }
            else
            {
                if (now->tail == head)
                    break;
                now = now->tailarc;
            }
        }
        if (now)
        {
            result.data = now->data;
            result.exist = true;
            return result;
        };
        {
            result.exist = false;
            return result;
        }
    }

    bool
    haveedge(int vertex)
    {
        return data_[vertex].firstarc != 0;
    }

    int vertex()
    {
        return nvertex_;
    }

    T getvertex(int vertex)
    {
        return data_[vertex].data;
    }

    int nvertex_;
    struct PointAdjmullist<T> *data_;
};

//图算法定义----------------------------------------------------------------

//todo:还有3种图的getaround没写

#include <queue>
template <class T>
int BFS(Graph<T> &G, int src, void func(T))
{
    std::queue<int> Q;
    if (src >= G.vertex() || src < 0)
    {
        return -1;
        //BFS falled;
    }

    Q.push(src);

    while (!Q.empty())
    {
        auto t = Q.front();
        func(t);
        Q.pop();
        auto V = G.vertex_around(t);
        Q.push(V);
    }
}

#include <stack>
template <class T>
int DFS(Graph<T> &G, int src, void func(T))
{
    //先序DFS
    std::stack<int> S;
    if (src >= G.vertex() || src < 0)
    {
        return -1;
        //DFS falled;
    }

    S.push(src);

    while (!S.empty())
    {
        auto t = S.top();
        func(t);
        S.pop();
        auto V = G.vertex_around(t);
        S.push(V);
    }
}

#include <set>
template <class T>
std::vector<std::pair<int, int>> Prim(Graph<T> &G, int src)
{
    //src is the point to start Algorithm Prim
    if (src < 0 || src >= G.vertex())
        throw("src out of range");
    std::set<int> S1;
    std::set<int> S2;
    T distance[G.nvertex_];
    std::pair<int, int> p;
    std::vector<std::pair<int, int>> now;
    char access[G.nvertex_]; //0-> no access now 1-> have access now -1-> have been accessed
    T min;
    for (int i = 0; i < G.vertex(); i++)
    {
        if (i == src)
        {
            S1.insert(i);
            distance[i] = 0;
            access[i] = -1;
        }
        else
        {
            S2.insert(i);
            distance[i] = G.getedge().data;
            access[i] = G.getedge().exist;
            if (G.getedge().exist)
                min = distance[i];
        }
        p.first = src;
        p.second = i;
        now.push_back(p);
    }
    //finished initialization

    std::vector<std::pair<int, int>> result;

    while (!S2.empty())
    {
        int minindex = -1;
        for (int i = 0; i < G.nvertex_; i++)
        {
            if (access[i] == 1)
            {
                if (distance[i] < min)
                {
                    min = distance[i];
                    minindex = i;
                }
            }
        }
        if (minindex == -1)
            break;
        S1.insert(minindex);
        S2.erase(minindex);
        result.push_back(now[minindex]);
        access[minindex] = -1;

        //update the shortest distance now:now;
        for (int i = 0; i < G.nvertix_; i++)
        {
            if (access[i] == 1)
            {
                if (G.getedge(minindex, i).exist)
                {
                    if (G.getedge(minindex, i).data <= distance[i] || access[i] == 0)
                    {
                        distance[i] = G.getedge(minindex, i).data;
                        access[i] = 1;
                        p.first = minindex;
                        p.second = i;
                        now[i] = p;
                    }
                }
            }
        }
    }
    return result;
}

#include "tree" //import disjoint set
template <class T>
std::vector<std::pair<int, int>> Kruskal(Graph<T> *G, int src)
{
    DisjointSet D(G.vertex());
    std::vector<std::pair<int, int>> result;
    std::pair<int, int> p;
    std::priority_queue<std::pair<int, int>> P;
    for (int a = 0; a < G->vertex(); a++)
        for (int b = 0; b < G->vertex(); b++)
        {
            if (G->existedge(a, b))
                P.push(std::pair<int, int>(a, b));
        };

    int psize = P.size();
    while (!D.unique() & !P.empty())
    {
        if (D.find(P.top().first) != D.find(P.top().second))
        {
            D.merge(P.top().first, P.top().second);
            result.push_back(std::pair<int, int>(P.top().first, P.top().second));
        }
        P.pop();
    }
    return result;
}

namespace GRAPH_TARJAN
{

int min(std::vector<int> &V)
{
    int min = V[0];
    for (int i : V)
    {
        if (i < min)
        {
            min = i;
        }
    }
}

template <class T>
int low(int a, Graph<T> *G, int *sequence, int *low, int &cnt, std::vector<int> &Q)
{
    ++cnt;
    sequence[a] = cnt;
    std::vector<int> V;
    V.push_back(cnt);
    auto M = G->vertex_around(a);
    for (auto i : M)
    {
        //subnode
        if (sequence[i] == -1)
        {
            V.push_back(low(i, G, sequence, low, cnt, Q));
            if (sequence[i] >= cnt)
            {
                Q.push_back(a);
            } //this is a articulation point
        }
        else
        {
            if (sequence[i] >= 0)
            { //fathernode
                V.push_back(sequence[i]);
            }
        }
    };
    low[a] = min(V);
}

} // namespace GRAPH_TARJAN

template <class T>
std::vector<int> Tarjan(Graph<T> *G, int root = 0) //ArticulationPoint
{
    //do remember this is a graph without direction.
    using namespace GRAPH_TARJAN;

    int sequence[G->vertex()];
    int low[G->vertex()];
    for (int i = 0; i < G->vertex(); i++)
    {
        sequence[i] = -1;
    }
    int cnt = 0;
    std::vector<int> result;

    auto W = G->vertex_around(root);
    if (W.size() > 1)
        result.push_back(root);
    for (auto i : W)
    {
        low(i, G, sequence, low, cnt, result);
    }

    return result;
    //todo : low!
}

template <class T>
bool isBiconnected(Graph<T> *G)
{
    //the graph is biconnected
    auto V = Tarjan(G);
    return V.size() == 0;
}

template <class T>
std::vector<int> TopologicalSort(Graph<T> *G)
{
    std::vector<int> V;
    int indegree[G->vertex()];
    for (int i = 0; i < G->vertex(); i++)
    {
        indegree[i] = G->indegree(i);
    }
    int p = G->vertex();
    while (p-- > 0)
    {
        for (int i = 0; i < G->vertex(); i++)
        {
            if (indegree[i] == 0)
            {
                V.push_back(i);
                auto S = G->vertex_around(i);
                for (auto i : S)
                {
                    indegree[i]--;
                }
                break;
            }
        }
    }
    return V;
}

template <class T>
bool haveRing(Graph<T> *G)
{
    return TopologicalSort(G)->size() == G->vertex();
}

template <class T>
std::vector<int> CriticalPath(Graph<T> *G)
{
    auto V = TopologicalSort(G);
    T distance[G->vertex()];
    T rdistance[G->vertex()];
    bool access[G->vertex()];
    bool raccess[G->vertex()];
    int t = G->vertex();
    for (int i = 0; i < t; i++)
    {
        distance[i] = rdistance[i] = 0;
        access[i] = false;
        raccess[i] = false;
    }

    access[V[0]] = true;
    for (int i = 1; i < t; i++)
    {
        T dmax = distance[i];
        for (int b = 0; b < t; b++)
        {
            if (access[b])
            {
                if (G->existedge(b, i))
                {
                    T u = distance[i] + G->edge(b, i).data;
                    if (u > dmax)
                    {
                        dmax = u;
                        access[i] = true;
                    }
                }
            }
        }
        if (access[i])
            distance[i] = dmax;
    }

    //reverse
    raccess[V[t - 1]] = true;
    rdistance[V[t - 1]] = distance[V[t - 1]];
    for (int i = t - 2; i >= 0; i--)
    {
        T dmin = rdistance[i];
        for (int b = 0; b < t; b++)
        {
            if (raccess[b])
            {
                if (G->existedge(i, b))
                {
                    T u = rdistance[i] - G->edge(i, b).data;
                    if (u < dmin)
                    {
                        dmin = u;
                        raccess[i] = true;
                    }
                }
            }
        }
        if (raccess[i])
            rdistance[i] = dmin;
    }

    std::vector<int> result;
    for (int i = 0; i < t; i++)
    {
        auto p = V[i];
        if (distance[p] == rdistance[p])
            result.push_back(p);
    }
    return result;
}

template <class T>
struct ResultShortestPath
{
    T length;
    std::vector<int> path;
};

template <class T>
ResultShortestPath<T> Dijkstra(Graph<T> *G, int src, int dst) //can not be used to deal witth graph with negative weight
//按点检查
{
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
    ResultShortestPath<T> result;
    result.length = distance[dst];

    std::vector<int> r;
    std::vector<int> r2;

    while (father[dst] != -1) //not head
    {
        r.push_back(dst);
        dst = father[dst];
    }
    r2.assign(r.rend(), r2.rbegin());
    result.path = r2;
    return result;
}

template <class T>
ResultShortestPath<T> Ford(Graph<T> *G, int src, int dst) //can deal with negative weight, and can also find negative circle
{
    int s = G->size();
    int father[s];
    int distance[s];
    for (int i = 0; i < s; i++)
    {
        father[i] = -1; //no father
    }
    father[src] = -2; //src
    auto elist = G->alledge();
    auto esize = elist.size();
    for (int i = 0; i < s - 1; i++)
    {
        for (int b = 0; b < esize; b++)
        {
            if (father[elist[b].first] != -1) //has father, can be relaxed
            {
                if (father[elist[b].second] != -1)
                {
                    father[elist[b].second] = elist[b].first;
                    distance[elist[b].second] = distance[elist[b].first] + G->edge(elist[b].first, elist[b].second).data;
                }
            }
            else
            {
                //has father, need compare;
                auto n = distance[elist[b].first] + G->edge(elist[b].first, elist[b].second).data;
                if (n < distance[elist[b].second])
                {
                    distance[elist[b].second] = n;
                    father[distance[elist[b].second]] = elist[b].first;
                }
            }
        }
    }

    ResultShortestPath<T> m;
    m.length = distance[dst];
    std::vector<int> r1;
    std::vector<int> r2;
    while (father[dst] != -2)
    {
        r1.push_back(dst);
        dst = father[dst];
    }
    r2.assign(r1.rend(), r1.rbegin());
    m.path = r2;
    return m;
}

template <class T>
struct ResultFloyd
{
    // std::vector<std::vector<std::vector<int>>> path;
    std::vector<std::vector<T>> length;
};

template <class T>
struct ResultFloyd<T> Floyd(Graph<T> *G)
{
    int s = G->size();
    bool inf[G->size()][G->size()];
    std::vector<std::vector<int>> result;
    while (s-- > 0)
    {
        result.push_back(std::vector<int>(s));
    }

    for (int a = 0; a < G->size(); a++)
    {
        for (int b = 0; b < G.size(); b++)
        {
            auto t = G->edge(a, b);
            if (t.exist)
            {
                inf[a][b] = false;
                result[a][b] = t.data;
            }
            else
            {
                inf[a][b] = true;
            }
        }
    }

    for (int k = 0; k < s; k++)
    {
        for (int a = 0; a < s; a++)
        {
            for (int b = 0; b < s; b++)
            {
                auto t1 = G->edge(a, k);
                auto t2 = G->edge(k, b);
                if (t1.exist & t2.exist)
                {
                    auto d = t1.data + t2.data;
                    if (inf[a][b] || (d < result[a][b]))
                    {
                        result[a][b] = d;
                    }
                }
            }
        }
    }
    return result;

}

#ifdef UNIT_TEST
int
main()
{
    using namespace std;
    GraphArray<int> G(3);
    G.zero();
    G.setedge(0, 0, 3);
    G.setedge(0, 1, 2);
    cout << G.getedge(0, 1).data << endl;

    GraphOrthgonal<int> S(5);
    S.setedge(0, 0, 3);
    S.setedge(0, 1, 2);
    cout << S.getedge(0, 1).data << endl;
    cout << S.getedge(0, 0).data << endl;

    GraphAdjmullist<int> Q(5);
    Q.setedge(1, 2, 3);
    Q.setedge(0, 1, 2);
    for (int j = 0; j < Q.nvertex_; j++)
    {
        auto i = Q.data_[j];
        cout << i.firstarc << endl;
    }
    cout << Q.getedge(0, 1).data << endl;
    cout << Q.getedge(2, 1).data << endl;
    cout << Q.getedge(0, 0).exist << endl;
    Q.getedge(3, 4);
    cout << Q.getedge(3, 4).exist << endl;
    Graph<int> *sp = &Q;
    sp->degree(0);
    cout << sp->vertex() << endl;
    Q.print();
    cout << Ford(&G, 0, 1).length << endl;
}
#endif
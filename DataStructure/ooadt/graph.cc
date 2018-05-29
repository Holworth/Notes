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

    virtual std::vector<std::pair<int, int>> getedge_around(int vertex)
    {
        std::cout << "Getedge_around func undefined." << std::endl;
        throw("Getedge_around func undefined.");
    }

    virtual std::vector<int> vertex_around(int vertex)
    {
        std::cout << "vertex_around func undefined." << std::endl;
        throw("vertex_around func undefined.");
    }

    friend bool operator<(const std::pair<int, int> e1, const std::pair<int, int> e2)
    {
        auto le1 = edge(e1.first, e1.second);
        auto le2 = edge(e2.first, e2.second);
        if (!le1.exist)
        {
            return false;
        }
        if (!le2.exist)
        {
            return true;
        }

        return le1.data < le2.data;
    }
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
        result.data = *(data_ + sizeof(T) * tail * nvertex_ + head);
        result.exist = *(exist_ + sizeof(T) * tail * nvertex_ + head);
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
    virtual int indegree(int vertex)
    {
        int res = 0;
        for (int i = 0; i < nvertex_; i++)
        {
            if (haveedge(i, vertex))
                res++;
        }
        return res;
    }
    virtual int outdegree(int vertex)
    {
        int res = 0;
        for (int i = 0; i < nvertex_; i++)
        {
            if (haveedge(vertex, i))
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

    int nvertex_;
    T *data_;
    int *mark_;
    bool *exist_;
};

//有向图的邻接表表示
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

    int nvertex_;
    struct PointOrthogonal<T> *data_;
};

//邻接多重表单向图
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

    int nvertex_;
    struct PointAdjmullist<T> *data_;
};

//图算法定义----------------------------------------------------------------

//todo:还有3种图的getaround没写

#include <queue>
template <class T>
int BFS(Graph<T> G, int src, void func(T))
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
int DFS(Graph<T> G, int src, void func(T))
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
std::vector<std::pair<int, int>> Prim(Graph<T> G, int src)
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
std::vector<std::pair<int, int>> Kruskal(Graph<T> G, int src)
{
    DisjointSet D(G.vertex());
    std::vector<std::pair<int, int>> result;
    std::pair<int, int> p;
    std::priority_queue<std::pair<int, int>> P;
    for (int a = 0; a < G.vertex(); a++)
        for (int b = 0; b < G.vertex(); b++)
        {
            if (G.haveedge(a, b))
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
int low(int i){
    //todo
};

int min(int a, int b)
{
    return (a < b) ? a : b;
}
} // namespace GRAPH_TARJAN

template <class T>
int Tarjan(Graph<T> G, int root = 0) //ArticulationPoint
{

    using namespace GRAPH_TARJAN;

    int sequence[G.vertex()];
    for (int i = 0; i < G.vertex(); i++)
    {
        sequence[i] = -1;
    }
    int cnt = 0;
    std::stack<int> S;
    std::vector<int> result;
    S.push(root);
    S.push(G.vertrx_around(root));
    if (S.size() > 1)
        result.push_back(root);

    //todo-----------------------------------------
    while (!S.empty())
    {
        sequence[S.top()] = min(1, 111);
        if (cnt >= low(G, S.top()))
        {
            result.push_back(S.top());
        }
        cnt++;
        auto t = S.top();
        S.pop();
        S.push(G.vertrx_around(t));
    }
    return result;
    //todo : low!
}

template <class T>
bool isBiconnected(Graph<T> G)
{
}

template <class T>
int TopologicalSort(Graph<T> G)
{
    int indegree[G.vertex()];
    for (int i = 0; i < G.vertex(); i++)
    {
        indegree[i] = G.indegree(i);
    }
}

template <class T>
std::vector<std::pair<int, int>> CriticalPath(Graph<T> G)
{
}

template <class T>
std::vector<int> Dijkstra(Graph<T> G, int src, int dst)
{
}

template <class T>
std::vector<int> Flod(Graph<T> G, int src, int dst)
{
}

template <class T>
struct ResultFloyd
{
    std::vector<std::vector<int>> path;
    std::vector<T> length;
};

template <class T>
struct ResultFloyd<T> Floyd(Graph<T> G)
{

}

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
}
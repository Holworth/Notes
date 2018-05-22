//OO_ADT_Code Project
//https://github.com/L-F-Z/ADT_Code
//https://github.com/AugustusWillisWang/Notes/tree/master/DataStructure/ooadt
//Developed by AugustusWillisWang

#include <iostream>
#include <exception>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <vector>

#include <string.h>
#include <stdio.h>

#include "adt.h"
#include "dbg.h"

#define MAGIC_MAX 23333

template <class T>
class GraphArray
{
  public:
    GraphArray(int a)
    {
        int i = a * a;
        _data = new T[i];
        _mark = new int[i];
        _a = a;
        while (i-- > 0)
        {
            _mark[i] = 0;
        }
    }
    ~GraphArray()
    {
        delete[] _data;
        delete[] _mark;
    }
    GraphArray<T>(const GraphArray<T> &src)
    {
        _a = src._a;
        for (int i = 0; i < _a * _a; i++)
        {
            *(_data + i) = *(src._data + i);
        }
    }
    T getedge(int tail, int head)
    {
        return *(_data + sizeof(T) * tail * _a + head);
    }
    bool setedge(int tail, int head, T value)
    {
        *(_data + tail * _a + head) = value;
    }
    bool setedgemark(int tail, int head)
    {
        *(_mark + tail * _a + head) = value;
    }
    zero()
    {
        for (int i = 0; i < _a * _a; i++)
        {
            *(_data + i) = 0;
            *(_mark + i) = 0;
        }
    }
    init()
    {
        for (int i = 0; i < _a * _a; i++)
        {
            *(_data + i) = MAGIC_MAX;
        }
    }

    int _a;
    T *_data;
    int *_mark;
};

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
class GraphAdjlist
{
  public:
    GraphAdjlist(int nvertix)
    {
        _data = new struct PointAdjlist<T>[nvertix];
        _nvertix = nvertix;
        while (nvertix-- > 0)
        {
            _data[nvertix].firstarc = 0;
            _data[nvertix].data = 0;
            _data[nvertix].mark = 0;
        }
    }
    ~GraphAdjlist()
    {
        delete[] _data;
    }
    int setedge(int tail, int head, T val)
    {
        struct ArcAdjlist<T> *now = _data[tail].firstarc;
        while (!now)
        {
            now = now->nextarc;
        }
        now->head = head;
        now->tail = tail;
        now->data = val;
        now->mark = 0;
        now->nextarc = 0;
    }

    T getedge(int tail, int head)
    {
        struct ArcAdjlist<T> *now = _data[tail].firstarc;
        while (!now && now->head != head)
            now = now->nextarc;
        if (now)
            return now->data;
        return MAGIC_MAX;
    }

    int _nvertix;
    struct PointAdjlist<T> *_data;
};

template <class T>
class GraphOrthenal
{
  public:
    GraphAdjlist(int nvertix)
    {
        _data = new struct PointAdjlist<T>[nvertix];
        _nvertix = nvertix;
        while (nvertix-- > 0)
        {
            _data[nvertix].firstarc = 0;
            _data[nvertix].data = 0;
        }
    }
    ~GraphAdjlist()
    {
        delete[] _data;
    }
    int setedge(int tail, int head, T val)
    {
        struct ArcAdjlist<T> *now = _data[tail].firstarc;
        while (!now)
        {
            now = now->nextarc;
        }
        now->head = head;
        now->tail = tail;
        now->data = val;
        now->mark = 0;
        now->nextarc = 0;
    }

    T getedge(int tail, int head)
    {
        struct ArcAdjlist<T> *now = _data[tail].firstarc;
        while (!now && now->head != head)
            now = now->nextarc;
        if (now)
            return now->data;
        return MAGIC_MAX;
    }

    int _nvertix;
    struct PointAdjlist<T> *_data;
};

int main()
{
    using namespace std;
    GraphArray<int> G(3);
    G.zero();
    G.setedge(0, 0, 3);
    G.setedge(0, 1, 2);
    cout << G.getedge(0, 1);
}
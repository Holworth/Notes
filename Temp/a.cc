
#include <iostream>
#include <stdio.h>

typedef struct node
{
    char data;
    struct node *next;
} node, *pnode;

using namespace std;

int printall(pnode now)
{
    bool c = 0;
    while (now->next)
    {
        now = now->next;
        if (!c)
        {
            c = 1;
        }
        else
        {
            cout << ",";
        }
        putchar(now->data);
    }
}

int insert(pnode last, char data)
{
    pnode p = last->next;
    last->next = new node;
    last->next->data = data;
    last->next->next = p;
    return 0;
}

int main()
{
    int mink, maxk;

    //init
    node head;
    head.next = 0;
    pnode phead = &head;
    pnode pnow = phead;

    node head1;
    head1.next = 0;
    pnode phead1 = &head1;
    pnode pnow1 = phead1;

    node head2;
    head2.next = 0;
    pnode phead2 = &head2;
    pnode pnow2 = phead2;

    int state = 0;

    char t;
    bool s = 1;
    while (cin >> t)
    {
        if (s)
        {
            pnow->next = new node;
            pnow = pnow->next;
            pnow->data = t;
            pnow->next = 0;
            s = 0;
        }
        else
        {
            if (t == ';')
            {
                switch (state)
                {
                case 0:
                    pnow = phead1;
                    state = 1;
                    break;
                case 1:
                    pnow = phead2;
                    break;
                }
            }
            if (t == ',')
            {
                //do nothing
            }
            s = 1;
        }
    }

    //delete
    pnow = phead;
    pnow1 = phead1;
    pnow2 = phead2;
    while (pnow->next)
    {
        if (pnow1->next&&(pnow->next->data > pnow1->next->data))
        {
            pnow1 = pnow1->next;
            continue;
        }
        if (pnow2->next&&(pnow->next->data > pnow2->next->data))
        {
            pnow2 = pnow2->next;
            continue;
        }
        if((pnow1->next==0)||(pnow2->next==0))
        {
            break;
        }
        if (pnow1->next && pnow2->next && pnow1->next->data == pnow->next->data && pnow2->next->data == pnow->next->data)
        {
            pnode l=pnow->next;
            pnow->next = pnow->next->next;
            delete l;
        }else
        {
            pnow = pnow->next;
        }
    }

                       // printall(phead);

                       // cout << endl;
                       printall(phead);
    // cout << endl;
    // printall(phead1);
    // cout << endl;
    // printall(phead2);
}
int global_var;

int leaf0()
{
    return global_var;
}

int nest0()
{
    return leaf0();
}

int leaf1(int v1)
{
    return global_var+v1;
}

int nest1(int v1)
{
    return leaf0(v1);
}

int leaf5(int v1, int v2, int v3, int v4, int v5)
{
    return global_var+v1+v2+v3+v4+v5;
}

int nest5(int v1, int v2, int v3, int v4, int v5)
{
    return leaf0(v1, v2, v3, v4, v5);
}

int main()
{
    leaf0();
    nest0();
    
    leaf1(1);
    nest1(1);

    leaf5(1,2,3,4,5);
    nest5(1,2,3,4,5);

}
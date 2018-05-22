//用扩展型嵌入式汇编完成下列程序：
// unsigned int shld5(unsigned int a, unsigned int b)
// {
    // unsigned int result;
    // result = (a << 5) |( b>>(32-5)); //此语句用嵌入式汇编编写
    // return result；
// }


unsigned int shld5(unsigned int a, unsigned int b)
{
    unsigned int result;
    //result = (a << 5) |( b>>(32-5)); //此语句用嵌入式汇编编写
    // asm("mov $1000,%0"
    //     : "=r"(result));

    __asm__(
        "shll $5,%1;\n\t"
        "movb $(32-5),%%cl;\n\t"
        "shrl %%cl,%2;\n\t"
        "orl %2,%1;"
        : [result] "=r"(result)
        : "0"(a), "g"(b)
        : "cl");

        //or

    // __asm__(
    //     "orl %2,%0;"
    //     : [result] "=r"(result)
    //     : "0"(a<<5), "g"(b>>(32-5)));
    return result;
}

int main()
{
    shld5(10086, 2333);
}

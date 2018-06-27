#include <cstdio>
// #include "trap.h"
// #include "mul.h"
// #include "div.h"
// #include "perf_cnt.h"

//todo : compile 1
//todo : add mul, etc 1
//todo : hardware 1
//todo : testit 0

using namespace std;

#define FRAC_BIT 10

//输入图片
// #define RD_ADDR 135106448
short *RD_ADDR;
#define RD_SIZE_D0 1
#define RD_SIZE_D1 1
#define RD_SIZE_D2 28
#define RD_SIZE_D3 28

//输入卷积核
short *WEIGHT_ADDR;
#define WEIGHT_SIZE_D0 20 //用于不同的卷积核个数
#define WEIGHT_SIZE_D1 1  //每个卷积核接收的通道数
#define WEIGHT_SIZE_D2 5  //卷积核尺寸
#define WEIGHT_SIZE_D3 5

//输出结果
short *WR_ADDR;
#define WR_SIZE_D0 1
#define WR_SIZE_D1 20
#define WR_SIZE_D2 12
#define WR_SIZE_D3 12

#define KERN_ATTR_CONV_PAD 0       //卷积paddle
#define KERN_ATTR_CONV_STRIDE 1    //卷积步长
#define KERN_ATTR_POOL_PAD 0       //池化paddle
#define KERN_ATTR_POOL_KERN_SIZE 2 //池化kernel尺寸
#define KERN_ATTR_POOL_STRIDE 2    //池化步长

// #define output(image, channel, x, y) *(WR_ADDR + x + WR_SIZE_D3 * (y + WR_SIZE_D2 * (channel + WR_SIZE_D1 * (image))))
#define output(out, image, channel, y, x) ((short *)(out + x + mul(conv_size.d3, (y + mul(conv_size.d2, (channel + mul(conv_size.d1, (image))))))))
// #define input(image, channel, x, y) *(RD_ADDR + x + RD_SIZE_D3 * (y + RD_SIZE_D2 * (channel + RD_SIZE_D1 * (image))))
#define input(in, image, channel, y, x) ((short *)(in + x + mul(rd_size.d3, (y + mul(rd_size.d2, (channel + mul(rd_size.d1, (image))))))))
// #define kernel(image, channel, x, y) *(WEIGHT_ADDR + x + WEIGHT_SIZE_D3 * (y + WEIGHT_SIZE_D2 * (channel + WEIGHT_SIZE_D1 * (image))))
#define kernel(weight, outchannel, channel, y, x) ((short *)(weight + 1 + x + mul(weight_size.d3, (y + mul(weight_size.d2, (channel + mul(weight_size.d1, (outchannel))))))))
// #define kernel(image, channel, x, y) *(WEIGHT_ADDR + x + WEIGHT_SIZE_D3 * (y + WEIGHT_SIZE_D2 * (channel + WEIGHT_SIZE_D1 * (image))))
#define bia(weight, outchannel, channel) ((short *)(weight + mul(weight_size.d3, (mul(weight_size.d2, (channel + mul(weight_size.d1, (outchannel))))))))
#define POOLING_STRIDE 2

struct size_vec4
{
    unsigned d0;
    unsigned d1;
    unsigned d2;
    unsigned d3;
};

struct mem_addr
{
    unsigned rd_addr;
    unsigned weight_addr;
    unsigned wr_addr;
};

int mul(short a, short b)
{
    // int ans = mul_ll(a, b);
    //change it to * when do * part
    return a * b;
}

struct mem_addr addr = {(unsigned)RD_ADDR, (unsigned)WEIGHT_ADDR, (unsigned)WR_ADDR};            //内存接口设置
struct size_vec4 rd_size = {RD_SIZE_D0, RD_SIZE_D1, RD_SIZE_D2, RD_SIZE_D3};                     //读取尺寸
struct size_vec4 wr_size = {WR_SIZE_D0, WR_SIZE_D1, WR_SIZE_D2, WR_SIZE_D3};                     //写入尺寸
struct size_vec4 weight_size = {WEIGHT_SIZE_D0, WEIGHT_SIZE_D1, WEIGHT_SIZE_D2, WEIGHT_SIZE_D3}; //权重尺寸

struct size_vec4 conv_size; //保存尺寸大小

//output and kernel remains, output point should - pad ::todo
// short kernel(image, channel, x, y) *(WEIGHT_ADDR + x + WEIGHT_SIZE_D3 * (y + WEIGHT_SIZE_D2 * (channel + WEIGHT_SIZE_D1 * (image))))

void convolution()
{
    //从指定地址读取in, weight, out
    // short *in = (short *)addr.rd_addr;
    // short *weight = (short *)addr.weight_addr;
    // short *out = (short *)addr.wr_addr;
    short *in = RD_ADDR;
    short *weight = WEIGHT_ADDR;
    short *out = WR_ADDR;

    unsigned output_offset = 0;
    unsigned input_offset = 0;
    unsigned weight_offset = 0;

    //定义输入的宽和高
    // unsigned input_fm_w = rd_size.d3;
    // unsigned input_fm_h = rd_size.d2;

    //定义paddle, 实际paddle大小为设置paddle的二倍.
    unsigned pad = KERN_ATTR_CONV_PAD;
    unsigned pad_len = pad << 1;

    //生成卷积结果尺寸
    unsigned conv_out_w = rd_size.d3 - weight_size.d3 + pad_len; //由结果尺寸公式生成
    unsigned conv_out_h = rd_size.d2 - weight_size.d2 + pad_len;

    unsigned stride = KERN_ATTR_CONV_STRIDE;

    conv_out_w = conv_out_w / stride; //由结果尺寸公式生成/stride
    conv_out_h = conv_out_h / stride;

    // printf("boom");
    //+1
    conv_out_w++;
    conv_out_h++;

    //卷积尺寸生成结束

    //生成整个结果集的尺寸
    conv_size.d0 = wr_size.d0;
    conv_size.d1 = wr_size.d1;
    conv_size.d2 = conv_out_h;
    conv_size.d3 = conv_out_w;

    //Algorithm implementaion

    int rd3 = rd_size.d3 + rd_size.d3 + rd_size.d3;

    // printf("boom");

    //使用软件模拟乘法
    for (int output_num = 0; output_num < wr_size.d0; output_num++) //输出个数
    {
        for (int output_c = 0; output_c < wr_size.d1; output_c++) //输出通道
        {
            //kernel在图像上按stride移动
            printf("----------\nchannel:%d\n", output_c);
            for (int output_y = 0; output_y < conv_out_h; output_y += 1) //每次输出一个位置
            {
                for (int output_x = 0; output_x < conv_out_w; output_x += 1) //每次输出一个位置
                {
                    // printf("now at: %d:%d\n", output_y, output_x);
                    for (int input_c = 0; input_c < rd_size.d1; input_c++)
                    {
                        *output(out,output_num,output_c,output_y,output_x) += *bia(out,output_c,input_c);
                        for (int kernel_y = 0; kernel_y < weight_size.d2; kernel_y++)
                        {
                            for (int kernel_x = 0; kernel_x < weight_size.d3; kernel_x++)
                            {
                                int input_x = output_x * KERN_ATTR_POOL_KERN_SIZE - pad;
                                int input_y = output_y * KERN_ATTR_POOL_KERN_SIZE - pad;

                                short input_value;
                                if (input_x < 0 | input_x >= conv_size.d3 | input_y < 0 | input_y >= conv_size.d2)
                                {
                                    input_value = 0;
                                }else
                                {
                                    input_value=*input(in,output_num, output_c, input_y, input_x);
                                }
                                *output(out,output_num,output_c,output_y,output_x) +=
                                    mul(*kernel(weight,output_c,input_c,kernel_y,kernel_x) , input_value);
                            }
                        }
                    }
                } //output_x
            }
        }
    }
}

// #define output(out, image, channel, y, x) ((short *)(out + x + mul(WR_SIZE_D3, (y + mul(WR_SIZE_D2, (channel + mul(WR_SIZE_D1, (image))))))))
#define pool_in(out, image, channel, y, x) output(out, image, channel, y, x)
#define pool_out(out, image, channel, y, x) ((short *)(out + x + WR_SIZE_D3* (y + WR_SIZE_D2* (channel + WR_SIZE_D1* (image)))))

void pooling()
{

    short *out = WR_ADDR;

    //again, WTF is it? TODO
    // unsigned output_offset = 0;
    // unsigned input_offset = 0;

    //这里暗示了w和h的对应关系
    unsigned input_fm_w = conv_size.d3;
    unsigned input_fm_h = conv_size.d2;
    unsigned input_channel = conv_size.d1;
    // unsigned pool_out_channel = conv_size.d1;
    unsigned input_image = conv_size.d0;

    unsigned pad = KERN_ATTR_POOL_PAD; //paddle=0
    unsigned pad_len = pad << 1;       //*2, paddle对图像大小的实际影响

    //计算pooling之后的尺寸
    unsigned pad_w_test = conv_size.d3 - KERN_ATTR_POOL_KERN_SIZE;
    unsigned pad_h_test = conv_size.d2 - KERN_ATTR_POOL_KERN_SIZE;

    unsigned pool_out_w = pad_w_test + pad_len;
    unsigned pool_out_h = pad_h_test + pad_len;

    unsigned stride = KERN_ATTR_POOL_STRIDE;

    //余下部分, 每能池化, 不知道要用来做什么
    unsigned pad_w_test_remain = pad_w_test - mul(pad_w_test / stride, stride);
    unsigned pad_h_test_remain = pad_h_test - mul(pad_h_test / stride, stride);

    pool_out_w = pool_out_w / stride;
    pool_out_h = pool_out_h / stride;
    pool_out_w++;
    pool_out_h++;

    //若没有paddle并且某个方向没有完全池化
    if ((!pad) && (pad_w_test_remain || pad_h_test_remain))
    {
        pool_out_w++;
        pool_out_h++;
    }
    //修改尺寸, 保留这一行.
    //应该被池化到这里的点会自动被取出最大值
    //每次从0,0开始因此必定被先初始化成第一个值
    //尺寸计算完成

    //Algorithm implementaion
    //计算每个像素池化之后的位置
    //没有cache, 所以可以为所欲为
    //同上, 含有paddle的性能损失应如何处理?

    // input_channel
    // input_image

    unsigned int pooling_in_offset = 0;
    unsigned int pooling_out_offset = 0;

    for (int image = 0; image < input_image; image++)
    {
        for (int channel = 0; channel < input_channel; channel++)
        {
            for (int out_y; out_y < pool_out_h; out_y++)
            {
                for (int out_x; out_x < pool_out_w; out_x++)
                {
                    int first = 1;
                    for (int in_x = out_x * KERN_ATTR_POOL_STRIDE - pad;
                         in_x < ((out_x + 1) * KERN_ATTR_POOL_STRIDE -pad);
                         in_x++)
                    {
                        for (int in_y = out_y * KERN_ATTR_POOL_STRIDE - pad;
                             in_x < ((out_x + 1) * KERN_ATTR_POOL_STRIDE - pad);
                             in_y++)
                        {
                            short getin;
                            if (in_x < 0 | in_x >= conv_size.d3 | in_y < 0 | in_y >= conv_size.d2)
                            {
                                getin = 0;
                            }
                            else
                            {
                                getin = *pool_in(addr.wr_addr, image, channel, out_y, out_x);
                            }

                            if (first)
                            {
                                *pool_out(addr.wr_addr, image, channel, out_y, out_x) =
                                    getin;
                            }
                            else
                            {
                                if (*pool_out(addr.wr_addr, image, channel, out_y, out_x) < getin)
                                {
                                    *pool_out(addr.wr_addr, image, channel, out_y, out_x) = getin;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#include <fstream>
#include <iostream>

int main()
{

    printf("Non HW acced conv and pooling start.\n");
    WEIGHT_ADDR = new short[WEIGHT_SIZE_D0 * WEIGHT_SIZE_D1 * (1+WEIGHT_SIZE_D2 * WEIGHT_SIZE_D3)];
    RD_ADDR = new short[RD_SIZE_D0 * RD_SIZE_D1 * RD_SIZE_D2 * RD_SIZE_D3];
    WR_ADDR = new short[WR_SIZE_D0 * WR_SIZE_D1 * WR_SIZE_D2 * WR_SIZE_D3];
    ifstream rd;
    rd.open("weight", ios::in);
    int mweight_size = WEIGHT_SIZE_D0 * WEIGHT_SIZE_D1 * (1+WEIGHT_SIZE_D2 * WEIGHT_SIZE_D3);
    int i = 0;
    while (i < mweight_size)
    {
        rd >> WEIGHT_ADDR[i++];
    }
    // i = 0;
    // while (i < mweight_size)
    // {
    //     cout << WEIGHT_ADDR[i++]<<endl;
    // }
    rd.open("raw_data", ios::in);
    int mrd_size = RD_SIZE_D0 * RD_SIZE_D1 * RD_SIZE_D2 * RD_SIZE_D3;
    i = 0;
    while (i < mrd_size)
    {
        rd >> RD_ADDR[i++];
    }
    i = 0;
    while (i < mrd_size)
    {
        cout << RD_ADDR[i++] << endl;
    }
    addr = {(unsigned)RD_ADDR, (unsigned)WEIGHT_ADDR, (unsigned)WR_ADDR};
    printf("starting convolution\n");
    convolution();
    printf("starting pooling\n");
    pooling();
    printf("Finally it is finished.....\n");
    printf("Non HW acced conv and pooling finished.\n");

    ofstream out;
    out.open("myresult.txt", ios::out | ios::trunc);
    i = 0;
    int mwr_size = WR_SIZE_D0 * WR_SIZE_D1 * WR_SIZE_D2 * WR_SIZE_D3;
    while (i < mwr_size)
    {
        out << WR_ADDR[i++] << " ";
    }

    return 0;
}

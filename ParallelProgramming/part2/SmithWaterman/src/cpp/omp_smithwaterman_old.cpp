#include "smithwaterman.h"
#include <omp.h>
#include <sys/types.h>
#include <sys/syscall.h>

namespace smith_waterman
{

struct sw_result
{
    int gap;
    int identity;
    double score;
    std::string match_str1;
    std::string match_str2;
};

double match_score_table[4][4] = {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}};

double match_score(char in1, char in2)
{
    return match_score_table[in1][in2];
}

int max3select(double in1, double in2, double in3)
{
    int result = 0;
    if (in2 > in1)
    {
        in1 = in2;
        result = 1;
    }
    if (in3 > in1)
    {
        in1 = in3;
        result = 2;
    }
    if (0>in1)
    {
        result = -1; // zero result
    }
    return result;
}

double abs_i(int i)
{
    return (i > 0) ? i : -i;
}

double gap_match_penalty(int pos1, int pos2, double A, double B)
{
    int abs = abs_i(pos1 - pos2);
    
    switch(abs){
        case 0:
            return 0;
        case 1:
            return A;
        default:
            return B;
    }
}

int double_zero(double in)
{
    return (in < 0.00001) && (in > -0.0001);
}

struct sw_result smith_waterman(std::vector<char> src1, std::vector<char> src2, double A, double B)
{
    struct sw_result res;
    // res.gap=2000;

    int len1 = src1.size();
    int len2 = src2.size();

    double array[len1 + 1][len2 + 1];
    int back_trace[len1 + 1][len2 + 1][2];
    for (int i = 0; i < (len1 + 1); i++)
    {
        array[i][0] = 0;
        back_trace[i][0][0]=-1;
        back_trace[i][0][1]=-1;
    }
    for (int i = 0; i < (len2 + 1); i++)
    {
        array[0][i] = 0;
        back_trace[0][i][0]=-1;
        back_trace[0][i][1]=-1;
    }

    //simple match

    double cmax[len2 + 1];
    int cmax_back[len2 + 1][2];
    for (int i = 0; i < (len2 + 1); i++)
    {
        cmax[i] = 0;
        cmax_back[i][0] = 0;
        cmax_back[i][1] = i;
    }

    int finished[len1+1][len2+1];
    for(int a=0; a < (len1 + 1); a++){
        for(int b = 0; b < (len2+1); b++){
            finished[a][b]=0;
        }
    }

    for(int a = 0; a< (len2+1); a++){
        finished[0][a]=1;
    }

    #pragma omp parallel for schedule(static, 1) 
    //each thread get one line in seq.
    for (int a = 1; a < (len1 + 1); a++)
    {
        double row_max = 0;
        int rmax_back[2];
        rmax_back[0] = a;
        rmax_back[1] = 0;
        for (int b = 1; b < (len2 + 1); b++)
        {
            printf("pid:%d,tid=%ld\n",getpid(),syscall(SYS_gettid));
            while(!finished[a-1][b]){
                //spin
            }
            // std::cout<<a<<" "<<b<<std::endl;
            double col_max = cmax[b];
            double normal_match = array[a - 1][b - 1] + match_score(src1[a - 1], src2[b - 1]);
            double row_match = row_max + gap_match_penalty(b, rmax_back[1], A, B);
            // std::cout<<"rmax"<<row_max<<std::endl;
            // std::cout<<"rmaxb"<<rmax_back[1]<<std::endl;
            double col_match = col_max + gap_match_penalty(a, cmax_back[b][0], A, B);
            int select = max3select(
                normal_match,
                row_match,
                col_match
                );
            // std::cout<<"match step: "<<select<<","<<normal_match<<","<<row_match<<","<<col_match<<std::endl;
            //update opt_array
            switch (select)
            {
            case -1:
                array[a][b] = 0;
                break;
            case 0:
                array[a][b] = normal_match;
                break;
            case 1:
                array[a][b] = row_match;
                break;
            case 2:
                array[a][b] = col_match;
                break;
            }
            //update back trace
            switch (select)
            {
            case -1:
                back_trace[a][b][0]=-1; // can not back trace
                back_trace[a][b][1]=-1; // can not back trace
            case 0:
                back_trace[a][b][0] = a - 1;
                back_trace[a][b][1] = b - 1;
                break;
            case 1:
                back_trace[a][b][0] = rmax_back[0];
                back_trace[a][b][1] = rmax_back[1];
                break;
            case 2:
                back_trace[a][b][0] = cmax_back[b][0];
                back_trace[a][b][1] = cmax_back[b][1];
                break;
            }

            //update row_max
            if (array[a][b] > row_max)
            {
                row_max = array[a][b];
                rmax_back[0] = a;
                rmax_back[1] = b;
                // std::cout<<"rud"<<row_max<<" "<<rmax_back[0]<<" "<<rmax_back[1]<<std::endl;
            }
            //update col_max
            if (array[a][b] > col_max)
            {
                cmax[b] = array[a][b];
                cmax_back[b][0] = a;
                cmax_back[b][1] = b;
                // std::cout<<"cud"<<cmax[b]<<" "<<cmax_back[b][0]<<" "<<cmax_back[b][1]<<std::endl;
            }
            finished[a][b]=1;
        }
    }
    //match finished

    //for debug: print the whole array 
    std::cout<<"Match array:"<<std::endl;
    for(int a=0; a< (len1+1); a++){
        for(int b=0; b<(len2+1); b++){
            std::cout<<array[a][b]<<" ";
        }
        std::cout<<std::endl;
    }

    std::cout<<"Back Trace array:"<<std::endl;
    for(int a=0; a< (len1+1); a++){
        for(int b=0; b<(len2+1); b++){
            std::cout<<"("<<back_trace[a][b][0]<<","<<back_trace[a][b][1]<<")"<<" ";
        }
        std::cout<<std::endl;
    }
    //back trace
    //do gap, match count here
    //build match str
    res.score=array[len1][len2];
    return res;
    // return 1;
}

} // namespace smith_waterman

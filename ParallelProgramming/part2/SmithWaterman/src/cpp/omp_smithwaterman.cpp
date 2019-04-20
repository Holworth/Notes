#include "smithwaterman.h"
#include <unistd.h>
#include <omp.h>

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

struct match
{
    int position;
    double value;
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
    if (0 > in1)
    {
        result = -1; // zero result
    }
    return result;
}

inline int abs_i(int i)
{
    return (i > 0) ? i : -i;
}

inline double gap_match_penalty(int pos1, int pos2, double A, double B)
{
    auto gap = abs_i(pos1 - pos2);
    switch(gap)
    {
        case 0: return 0;
        case 1: return B;
        default: return (gap-1)*A+B;
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
        back_trace[i][0][0] = -1;
        back_trace[i][0][1] = -1;
    }
    for (int i = 0; i < (len2 + 1); i++)
    {
        array[0][i] = 0;
        back_trace[0][i][0] = -1;
        back_trace[0][i][1] = -1;
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


    //each thread get one line in seq.
    #pragma omp parallel for schedule(dynamic) 
    for (int a = 1; a < (len1 + 1); a++)
    {
        for (int b = 1; b < (len2 + 1); b++)
        {
            while(!finished[a-1][b]){
                //spin
            }
            // std::cout<<omp_get_thread_num()<<std::endl;

            struct match normal_match = {0, array[a - 1][b - 1]};
            struct match row_match;
            struct match col_match;

            //row match
            double max = 0;
            int max_position = 0;
            for(int i=0; i<b; i++){
                auto val = array[a][i] - gap_match_penalty(b, i, A, B);
                if(val>max){
                    max=val;
                    max_position=i;
                }
            }
            row_match.position=max_position;
            row_match.value=max;

            //col match
            max = 0;
            max_position = 0;
            for(int i=0; i<a; i++){
                auto val = array[i][b] - gap_match_penalty(a, i, A, B);
                if(val>max){
                    max=val;
                    max_position=i;
                }
            }
            col_match.position=max_position;
            col_match.value=max;

            int select = max3select(
                normal_match.value,
                row_match.value,
                col_match.value);
            // std::cout<<"match step: "<<select<<","<<normal_match<<","<<row_match<<","<<col_match<<std::endl;
            //update opt_array
            switch (select)
            {
            case -1:
                array[a][b] = 0;
                break;
            case 0:
                array[a][b] = normal_match.value;
                break;
            case 1:
                array[a][b] = row_match.value;
                break;
            case 2:
                array[a][b] = col_match.value;
                break;
            }
            //update back trace
            switch (select)
            {
            case -1:
                back_trace[a][b][0] = -1; // can not back trace
                back_trace[a][b][1] = -1; // can not back trace
            case 0:
                back_trace[a][b][0] = a - 1;
                back_trace[a][b][1] = b - 1;
                break;
            case 1:
                back_trace[a][b][0] = a;
                back_trace[a][b][1] = row_match.position;
                break;
            case 2:
                back_trace[a][b][0] = col_match.position;
                back_trace[a][b][1] = b;
                break;
            }
            // std::cout<<"iii"<<std::endl;
            finished[a][b]=1;
        }
    }
    //match finished

    //for debug: print the whole array
    std::cout << "Match array:" << std::endl;
    for (int a = 0; a < (len1 + 1); a++)
    {
        for (int b = 0; b < (len2 + 1); b++)
        {
            std::cout << array[a][b] << " ";
        }
        std::cout << std::endl;
    }

    std::cout << "Back Trace array:" << std::endl;
    for (int a = 0; a < (len1 + 1); a++)
    {
        for (int b = 0; b < (len2 + 1); b++)
        {
            std::cout << "(" << back_trace[a][b][0] << "," << back_trace[a][b][1] << ")"
                      << " ";
        }
        std::cout << std::endl;
    }
    //back trace
    //do gap, match count here
    //build match str
    res.score = array[len1][len2];

    //TODO trace back

    return res;
    // return 1;
}

} // namespace smith_waterman

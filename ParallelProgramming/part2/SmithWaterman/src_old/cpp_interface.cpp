#include "smithwaterman.h"
#include <chrono>   
// #include <time.h>

using namespace std;

double A, B;
int gap = 0, identity = 0;
char *input1;
char *input2;
char *output;

char *input1_str;
char *input2_str;

std::vector<char> input1_array={nA, nT, nC, nA, nT, nC, nA, nT, nC, nA, nT, nC};
std::vector<char> input2_array={nA, nA, nT, nC, nA, nT, nC, nA, nT, nC, nA, nT};

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

extern struct sw_result smith_waterman(std::vector<char> src1, std::vector<char> src2, double A, double B);

std::vector<char> nucleotides_str_to_vec(std::string src_str, int len){
    std::vector<char> dst_vec;
    int i=0;
    while(i<len){
        char c = -1;
        switch(src_str[i]){
            case 'A': c=nA; break;
            case 'T': c=nT; break;
            case 'C': c=nC; break;
            case 'G': c=nG; break;
        }
        dst_vec.push_back(c);
    }
    return dst_vec;
}

} // namespace smith_waterman

int get_input()
{
}

int main(int argc, char *argv[], char *envp[])
{
    cout << endl
         << "Smith_waterman Baseline." << endl
         << "Compiled at : " << __DATE__ << " " << __TIME__ << endl;
    if (argc == 6)
    {
        input1 = argv[1];
        input2 = argv[2];
        output = argv[3];
        A = atof(argv[4]);
        B = atof(argv[5]);
        get_input();

        auto time1=chrono::system_clock::now();
        auto res = smith_waterman::smith_waterman(input1_array, input2_array, A, B);
        auto time2=chrono::system_clock::now();
        auto duration = chrono::duration_cast<chrono::microseconds>(time2-time1);
        cout << "Score:" <<res.score << endl;
        cout << "Time:" << double(duration.count()) << endl;

        return 0;
    }
    else
    {
        cout << "Smith_waterman Baseline get invalid argument." << endl;
        return -1;
    }
}
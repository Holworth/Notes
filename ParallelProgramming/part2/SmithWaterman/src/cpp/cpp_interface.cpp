#include "smithwaterman.h"
#include <chrono>  
#include <fstream> 
// #include <time.h>

using namespace std;

double A, B;
int gap = 0, identity = 0;
char *input1;
char *input2;
char *value_matrix;

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
extern double match_score_table[26][26];

int set_match_score_table(char* name)
{
    for0(a,1,26){
        for0(b,1,26){
            match_score_table[a][b]=0;
            if(a==b)
                match_score_table[a][b]=1;
            // std::cout<<a<<" "<<b<<std::endl;
        }
    }
    return 0;
}


// std::vector<char> nucleotides_str_to_vec(std::string src_str, int len){
//     std::vector<char> dst_vec;
//     int i=0;
//     while(i<len){
//         char c = -1;
//         switch(src_str[i]){
//             case 'A': c=nA; break;
//             case 'T': c=nT; break;
//             case 'C': c=nC; break;
//             case 'G': c=nG; break;
//         }
//         dst_vec.push_back(c);
//         i++;
//     }
//     return dst_vec;
// }

std::vector<char> str_to_vec(std::string src_str){
    auto len=src_str.length();
    std::vector<char> dst_vec;
    const char* cstr=src_str.c_str();
    int i=0;
    while(i<len){
        char c = cstr[i]-'A';
        dst_vec.push_back(c);
        i++;
    }
    return dst_vec;
}

std::string read_input_file(char* name){
    ifstream fin(name, ios::in);
    std::string res;
    std::string buffer;
    std::getline(fin,buffer);//discard the first line
    while(std::getline(fin,buffer))
    {
        // std::cout<<"buf: "<<buffer<<std::endl;
        int i=0;
        auto s = buffer.c_str();
        while((s[i]<='Z')&&(s[i]>='A')){
            res.push_back(s[i]);
            i++;
        };
        // std::cout<<"res: "<<res<<std::endl;
    }
    // return "ACGGTTTTTTTTTBSUDYAOPPSDFPSTAAAAAAAA";
    // std::cout<<"-----------------------------"<<std::endl;
    return res;
};

} // namespace smith_waterman

int get_input()
{
    auto str1 = smith_waterman::read_input_file(input1);
    auto str2 = smith_waterman::read_input_file(input2);
    smith_waterman::set_match_score_table(value_matrix);
    input1_array=smith_waterman::str_to_vec(str1);
    input2_array=smith_waterman::str_to_vec(str2);
}

int main(int argc, char *argv[], char *envp[])
{
    cout << endl
         << "Smith_waterman Cpp Baseline." << endl
         << "Compiled at : " << __DATE__ << " " << __TIME__ << endl;
    if (argc == 6)
    {
        input1 = argv[1];
        input2 = argv[2];
        value_matrix = argv[3];
        A = atof(argv[4]);
        B = atof(argv[5]);
        get_input();

        // for debug

        auto time1=chrono::system_clock::now();
        auto res = smith_waterman::smith_waterman(input1_array, input2_array, A, B);
        auto time2=chrono::system_clock::now();
        // std::chrono::duration<double> duration =  time2-time1;
        auto duration = chrono::duration_cast<chrono::milliseconds>(time2-time1);
        cout << "Score:" <<res.score << endl;
        cout << "Running Time: " << double(duration.count()) <<"  milliseconds."<< endl;

        return 0;
    }
    else
    {
        cout << "Smith_waterman Baseline get invalid argument." << endl;
        return -1;
    }
}
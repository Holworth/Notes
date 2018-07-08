#include "head.cc"
#include "io.cc"
#include "dijkstra.cc"

using namespace std;

int usage()
{
    cout << "Usage:" << endl
         << "1. Interactive data input." << endl
         << "2. Interactive path design." << endl
         << "3. Save city data to csv." << endl
         << "4. Save runs/flights data to csv." << endl
         << "5. Read city data from csv." << endl
         << "6. Read runs/flights data from csv." << endl
         << "0. Exit." << endl;
    return 0;
}

int main()
{
    //DONE read file
    //TODO api
    //DONE read input
    //TODO cli-interface
    cout << "National Transportation Analog." << endl
         << "Compiled at " << __DATE__ << "," << __TIME__ << endl
         << "By William Wang " << endl
         << "Group members: X. Cai, Y. Liu, H. Wang" << endl
         << "---------------------------------------" << endl;
    class Dijkstra engine;
    while (1)
    {

        usage();
        cout << "Input:";
        int ins;
        cin >> ins;
        switch (ins)
        {
        case 0:
            exit(0);
            break;
        case 1:
            interactive_input();
            break;
        case 2:
            engine.update_data();
            engine.interactive_lookup();
            break;
        case 3:
            save_city();
            break;
        case 4:
            save_run();
            break;
        case 5:
            read_city();
            break;
        case 6:
            read_run();
            break;
        default:
            break;
        }
    }
    return 0;
}
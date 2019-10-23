#include <fstream>
#include <iostream>
#include <vector>
#include <iterator>
#include <unordered_map>
#include <boost/range/adaptors.hpp>

// hint: g++ 02.cpp -O2 -o cpp02


using namespace std;
using namespace boost;

int main()
{
    vector<string> line;
    ifstream ifs("input.txt", ifstream::in);
    istream_iterator<string> input(ifs);
    copy(input, istream_iterator<string>(),
         back_inserter(line));

    unordered_map<char,int> char_count;
    unsigned int twos = 0;
    unsigned int threes = 0;

    for (string s : line)
    {
        for (char c : s)
            ++char_count[c];

        auto counts = adaptors::values(char_count);
        if (find(counts.begin(), counts.end(), 2) != counts.end())
            ++twos;
        if (find(counts.begin(), counts.end(), 3) != counts.end())
            ++threes;

        char_count.clear();
    }

    cout << twos*threes << endl;

    return 0;
}

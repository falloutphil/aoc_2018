#include <fstream>
#include <iostream>
#include <unordered_map>
#include <boost/range/adaptors.hpp>
#include <boost/range/algorithm/find.hpp>

// hint: g++ 02.cpp -O2 -o cpp02

using namespace std;
using namespace boost;

int main()
{
    ifstream ifs("input.txt", ifstream::in);
    istream_iterator<string> input(ifs), eos;
    unordered_map<char,int> char_count;
    unsigned int twos, threes = 0;

    do
    {
        for (const char c : *input)
            // Increment count for each occurrence
            // of a char c in each line of the input
            ++char_count[c];

        // Get all the counts for the line
        // We don't care about which keys we counted
        const auto& counts = adaptors::values(char_count);
        // If any char occurred 2 or 3 times, increment
        if (find(counts, 2) != counts.end())
            ++twos;
        if (find(counts, 3) != counts.end())
            ++threes;

        // Delete counts to reuse for next line
        char_count.clear();
    }
    while(++input != eos); // is next line end of stream?

    cout << twos*threes << endl;

    return 0;
}

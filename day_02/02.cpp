#include <fstream>
#include <iostream>
#include <unordered_map>
#include <algorithm>
#include <vector>
#include <boost/range/adaptors.hpp>
#include <boost/range/algorithm/find.hpp>
#include <boost/range/combine.hpp>
#include <boost/range/algorithm.hpp>
#include <boost/range/adaptors.hpp>

// hint: g++ 02.cpp -O3 -o cpp02

// Runs in ~0.01s

using namespace std;
using namespace boost;

int main()
{
    unsigned int twos = 0, threes = 0;
    ifstream ifs("input.txt", ifstream::in);
    istream_iterator<string> input(ifs);
    vector<string> lines;
    copy(input, istream_iterator<string>(),
         back_inserter(lines));

    // **** First Part ****

    unordered_map<char,int> char_count;

    for(const string& line : lines)
    {
        for (const char c : line)
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

    cout << twos*threes << endl;

    // **** Second Part ****

    // Find two box ids that differ by 1
    // And then, remove the differing char
    string bitmask(2, 1); // K leading 1's (K=2 here)
    bitmask.resize(lines.size(), 0); // N-K trailing 0's

    // permute bitmask
    do {
        // K=2 so there will always be a only a first and last
        string& res1 = lines[bitmask.find_first_of(1)];
        string& res2 = lines[bitmask.find_last_of(1)];

        auto line_tuple = combine(res1, res2);
        const int mismatches =
            count_if( line_tuple.begin(), line_tuple.end(),
                 [](const auto& lt)
                 {
                     char r1, r2;
                     tie(r1, r2) = lt;
                     return r1 != r2;
                 });

        // Hmm a bit over the top!
        if (mismatches == 1) {
            transform(line_tuple |
                      adaptors::filtered([](const auto& lt)
                                         {
                                             char r1, r2;
                                             tie(r1, r2) = lt;
                                             return r1 == r2;
                                         }),
                      ostream_iterator<char>(cout),
                      [](const auto& lt)
                      {
                          char r1, r2;
                          tie(r1, r2) = lt;
                          return r1;
                      });

            cout << endl;
            break;
        }

    } while (prev_permutation(bitmask.begin(), bitmask.end()));

    return 0;
}

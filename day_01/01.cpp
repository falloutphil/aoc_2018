#include <algorithm>
#include <numeric>
#include <iterator>
#include <vector>
#include <fstream>
#include <iostream>

using namespace std;

int main()
{
    vector<int> freqs;
    ifstream ifs("input.txt", ifstream::in);
    istream_iterator<int> input(ifs);
    copy(input, std::istream_iterator<int>(),
         back_inserter(freqs));

    //for (const auto i: freqs)
    //    cout << i << ' ';

    int result = accumulate(begin(freqs),
                            end(freqs),
                            0, plus<int>());

    cout << result << endl;

    return 0;
}

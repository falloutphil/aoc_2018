#include <fstream>
#include <iostream>
#include <numeric>
#include <vector>
#include <map>
#include <boost/iterator/iterator_adaptor.hpp>

// hint: g++ 01.cpp -O2 -o cpp01

using namespace std;

template <class BaseIterator>
class cycle_iterator
    : public boost::iterator_adaptor<
    cycle_iterator<BaseIterator>,   // Derived
    BaseIterator,                   // Base
    boost::use_default,             // Value
    boost::forward_traversal_tag    // CategoryOrTraversal
    >
{
private:
    BaseIterator m_itBegin;
    BaseIterator m_itEnd;

public:
    cycle_iterator( BaseIterator itBegin, BaseIterator itEnd )
        : cycle_iterator::iterator_adaptor_(itBegin), m_itBegin(itBegin), m_itEnd(itEnd)
    {}

    void increment()
    {
        if (++this->base_reference() == this->m_itEnd)
        {
            this->base_reference() = this->m_itBegin;
        }
    }
};

int main()
{
    vector<int> freqs;
    ifstream ifs("input.txt", ifstream::in);
    istream_iterator<int> input(ifs);
    copy(input, istream_iterator<int>(),
         back_inserter(freqs));

    int result = accumulate(begin(freqs),
                            end(freqs),
                            0, plus<int>());

    cout << result << endl;

    auto cycle =
        cycle_iterator<vector<int>::const_iterator>(begin(freqs),
                                                    end(freqs));

    int cs = 0;
    map<int,bool> counter;

    while(!counter.count(cs))
    {
        counter[cs] = true;
        cs += *cycle++;;
    }

    cout << cs << endl;

    return 0;
}

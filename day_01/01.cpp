#include <algorithm>
#include <numeric>
#include <iterator>
#include <vector>
#include <map>
#include <fstream>
#include <iostream>
#include <boost/iterator/iterator_adaptor.hpp>

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
    copy(input, std::istream_iterator<int>(),
         back_inserter(freqs));

    //for (const auto i: freqs)
    //    cout << i << ' ';

    int result = accumulate(begin(freqs),
                            end(freqs),
                            0, plus<int>());

    cout << result << endl;

     auto cycle =
        cycle_iterator<vector<int>::const_iterator>(begin(freqs),
                                                    end(freqs));

    int cs = 0;

    for(int i=0;i<1040;i++)
    {
        cout << *cycle << ' ';
        ++cycle;
    }

    //int result2 = accumulate(cycle,
    //                        end(freqs),
    //                        0, plus<int>());



    return 0;
}

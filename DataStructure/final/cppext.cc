#ifndef CPPEXT_CC_
#define CPPEXT_CC_

#include<vector>
#include<string>

namespace cppext
{
std::vector<std::string> spilt(const std::string &s,const char& c)
{
    std::vector<std::string> v;
    std::string buffer;
    for (auto n:s)
    {
        if(n!=c)
        {
            buffer +=n;
        }else
        {
            v.push_back(buffer);
            buffer.clear();
        }
    }
    if(buffer.empty())
    {
        return v;
    }else
    {
        v.push_back(buffer);
        return v;
    }
}
}


#endif
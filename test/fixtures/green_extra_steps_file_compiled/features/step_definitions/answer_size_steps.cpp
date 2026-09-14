#include <gtest/gtest.h>
#include <cucumber-cpp/autodetect.hpp>
#include <string>
#include "hiker.hpp"

namespace
{

THEN("^answering (\\d+) times (\\d+) gives (\\d+) digits$")
{
    REGEX_PARAM(int, multiplier);
    REGEX_PARAM(int, multiplicand);
    REGEX_PARAM(size_t, digits);
    ASSERT_EQ(digits, std::to_string(answer(multiplier, multiplicand)).size());
}


}//namespace

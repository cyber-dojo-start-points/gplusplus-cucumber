#include <gtest/gtest.h>
#include <cucumber-cpp/autodetect.hpp>
#include "hiker.hpp"
#include "checksum.hpp"

namespace
{

using cucumber::ScenarioScope;

struct HikerCtx
{
    size_t result = 0;
};

GIVEN("^the hitch-hiker selects some tiles$")
{
}

WHEN("^they spell (\\d+) times (\\d+)")
{
    REGEX_PARAM(size_t, multiplier);
    REGEX_PARAM(size_t, multiplicand);
    ScenarioScope<HikerCtx> context{};
    context->result = answer(multiplier, multiplicand);
}

THEN("^the score has checksum (\\d+)$")
{
    REGEX_PARAM(int, expected);
    ScenarioScope<HikerCtx> context{};
    ASSERT_EQ(expected, checksum(static_cast<int>(context->result)));
}


}//namespace

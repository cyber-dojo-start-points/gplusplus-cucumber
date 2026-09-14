#include "hiker.hpp"
#include <iostream>

// The makefile starts the step-definitions binary with its stdout sent to
// /dev/null, so this print never reaches the learner. A print aimed at
// stderr is the one that arrives.
int answer(int a, int b)
{
    std::cout << "debug: answer was called" << std::endl;
    return a * b;
}

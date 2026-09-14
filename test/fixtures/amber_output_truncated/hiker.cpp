#include "hiker.hpp"
#include <iostream>

// The makefile starts the step-definitions binary with its stdout sent to
// /dev/null, so a print aimed at stdout is never seen. A print aimed at
// stderr is, and the runner keeps only the first 50K of each stream.
int answer(int a, int b)
{
    for (int i = 0; i != 4000; i++)
    {
        std::cerr << "debug: i is " << i << ", total is " << (i * 2) << std::endl;
    }
    return a * b;
}

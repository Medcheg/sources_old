#include <iostream>
#include <limits.h>
#include <conio.h>
#include "Thread.h"

void HelpOutput()
{
    std::cout << "Threading - command line parameters\n\n";
    std::cout << "Threading.exe [X Y]" << std::endl;
    std::cout << "X  : threads count, (1 < X <= 64) " << std::endl;
    std::cout << "Y  : buffer length, (1 < Y < MAX_INTEGER)" << std::endl;
}

int main (int args_count, char **args)
{
    if ( args_count < 3 )
    {
        HelpOutput();
        return 0;
    }

    // Get X value
    int X = atoi(args[1]);
    if ( X < 1 || X > 64)
    {
        HelpOutput();
        return 0;
    }

    // Get Y value
    int Y = atoi(args[2]);
    if ( Y < 1 || Y >= LONG_MAX )
    {
        HelpOutput();
        return 0;
    }

    // Starting Threads 
    std::cout << "\n  Program In the process, press any key for stop \n\n";

    CThreadFactory *threadFactory = new CThreadFactory(X, Y);
    threadFactory->Start();

    _getch();

    // Stop Factory
    threadFactory->Stop();

    // Waiting for stopping factory

    // create Reports
    int id_sum = 0;
    std::cout << "  # \tValues per thread \tHits Count\n\n";
    for ( int i = 0; i < threadFactory->get_ThreadCount(); i++)
    {
        CThread *thread = threadFactory->get_Thread(i);
        int id_count = threadFactory->get_Thread(i)->get_count_IDs();
        id_sum += id_count;
        std::cout << "  ";
        std::cout << thread->get_ID() << "\t\t";
        std::cout << id_count << "\t\t";
        std::cout << thread->get_count_Thread_hits_Number() << "\t\t";
        std::cout << std::endl;
        //std::cout << thread->get_SleepValue() << std::endl;
    }
    std::cout << "\n\n";
    std::cout << "Total: " << id_sum << std::endl;
        
    delete threadFactory;
    threadFactory = NULL;

    _getch();

    return 0;
}

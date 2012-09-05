#include <stdio.h>
#include "thread.h"
#include "test.h"

#define N 1024
#define MAX_TIME 5

void ThreadProc()
{
    printf("Thread proc from static function\n");
}

void main(int /*argc*/, char* /*argv*/[])
{
    A a;
    B b;
    Thread thread1(NewDelegate(&a, &A::ThreadProc), true);
    Thread thread2(NewDelegate(&b, &B::ThreadProc), true);
    Thread thread3(NewDelegate(ThreadProc), true);

    LARGE_INTEGER freq;
    LARGE_INTEGER start;
    LARGE_INTEGER current;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&start);

    thread1.Resume();
    thread2.Resume();
    thread3.Resume();

    int cnt = 0;
    do
    {
        int* data = new int[N];
        for(int i = 0; i < N; i++) data[i] = i;
        delete[] data;

        cnt++;

        QueryPerformanceCounter(&current);
    } while((MAX_TIME * freq.QuadPart) > (current.QuadPart - start.QuadPart));

    thread1.Abort();
    thread2.Abort();
}

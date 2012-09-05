#ifndef _TEST__INC_
#define _TEST__INC_

class A
{
public:
    A() { }

    virtual void ThreadProc()
    {
        printf("Thread proc from class A\n");
    }
};

class B : public A
{
public:
    B() { }

    virtual void ThreadProc()
    {
        printf("Thread proc from class B\n");
    }
};

#endif
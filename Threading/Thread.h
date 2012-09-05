#pragma once

#include <windows.h>

// Эту структуру необходимо переписать с помощью темплейтов
typedef struct tag_CircleBuffer
{
    int   *values;
    int    BufferDepth;
    int    index_curr, index_end;
    bool   isInited;

    void Init() 
    { 
        memset(values, 0, sizeof(float) * BufferDepth ); 
        index_curr = 0; 
        index_end  = 0; 
        isInited   = false; 
    }

    void Push( int val) 
    { 
        if ( values != NULL ) values[ index_curr++ ] = val; 
        
        if ( index_curr >= BufferDepth ) isInited = true; 
        if ( isInited == true ) 
        { 
            index_curr = index_end; 
            if ( ++index_end >= BufferDepth ) 
                index_end = 0; 
        } 
    }
    int get_BufferDepth() 
    {
        return BufferDepth;
    };

    int get_Value( int index ) 
    {
        int pos = index_curr + index;
        if ( pos >=  BufferDepth ) 
            pos = pos - ((pos/BufferDepth)*BufferDepth);

        if ( pos <= -BufferDepth ) 
            pos = pos + ((pos/BufferDepth)*BufferDepth);

        return values[pos];
    };
    void set_Value( int index, int value ) 
    {
        int pos = index_curr + index;
        if ( pos >=  BufferDepth ) 
            pos = pos - ((pos/BufferDepth)*BufferDepth);

        if ( pos <= -BufferDepth ) 
            pos = pos + ((pos/BufferDepth)*BufferDepth);

        values[pos] = value;
    }

    tag_CircleBuffer( int buff_depth) 
    { 
        BufferDepth = buff_depth;  
        values = (int*) malloc ( BufferDepth * sizeof(int) ); 
        Init();
    }
   ~tag_CircleBuffer() 
   { 
       free ( values ); 
       values = NULL; 
   }

}TCircleBuffer;


class CThread;
class CThreadFactory
{
private:
    CThread      **Thread_List;
    int            fThread_count;  
    TCircleBuffer *fCBuffer;

    HANDLE hCanPushValue;
public:
    CThreadFactory( int thread_count, int container_depth);
   ~CThreadFactory();

    void Start();
    void Stop();
    CThread *get_Thread( int index );
    int      get_ThreadCount();
};

class CThread
{
private:
    TCircleBuffer *pCBuffer;
private:
    int  fThread_id;
    int  fSleepValue;
    bool isThreadStarted;
    int  fThread_hits_Number;

    static void ThreadProc(void *param);

    HANDLE hCanPushValue;
    HANDLE hTerminate;
    HANDLE hTerminated;
public:
    void Start();
    void Stop();

    int get_ID();
    int get_count_IDs();
    int get_count_Thread_hits_Number();
    int get_SleepValue();
    CThread( TCircleBuffer *_CBuffer, HANDLE _canPushValue );
   ~CThread();
};

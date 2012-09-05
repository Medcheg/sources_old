#include <process.h> /* _beginthread, _endthread */
#include <ctime>     /* time */ 

#include "Thread.h"

CThreadFactory::CThreadFactory( int thread_count, int container_depth )
{
    // sets the starting point for random number ( its for sleeping threads)
    srand((unsigned)time(NULL)); 

    // Creating Events
    hCanPushValue = CreateEvent(NULL, FALSE,  TRUE, NULL);

    // Кольцевой буфер
    fCBuffer = new TCircleBuffer(container_depth);

    // Creating list of threads
    fThread_count   = thread_count;
    Thread_List   = new CThread*[fThread_count];

    for ( int i = 0; i < fThread_count; i++)
        Thread_List[i] = new CThread(fCBuffer, hCanPushValue );

}

CThreadFactory::~CThreadFactory()
{
    // destroy tread list
    for ( int i = 0; i < fThread_count; i++)
    {
        if ( Thread_List[i] != NULL ) 
        {
            delete Thread_List[i];
            Thread_List[i] = NULL;
        }
    }
    delete [] Thread_List;
    Thread_List = NULL;

    delete fCBuffer;

    CloseHandle(hCanPushValue);
}

void CThreadFactory::Start()
{
    for ( int i = 0; i < fThread_count; i++ )
        Thread_List[i]->Start();
}

void CThreadFactory::Stop()
{
    for ( int i = 0; i < fThread_count; i++ )
        Thread_List[i]->Stop();
}

CThread *CThreadFactory::get_Thread( int index )
{
    return ( index < 0 || index >= fThread_count ) ? NULL : Thread_List[ index ];
}

int CThreadFactory::get_ThreadCount()
{
    return fThread_count;
}

CThread::CThread( TCircleBuffer *_CBuffer, HANDLE _canPushValue )
{
    pCBuffer = _CBuffer;
    hCanPushValue = _canPushValue;

    static int thread_counter = 0;

    fThread_id = ++thread_counter;

    fSleepValue = rand()%15; 
    isThreadStarted = false;

    // Creating Events
    hTerminate  = CreateEvent(NULL, FALSE, FALSE, NULL);
    hTerminated = CreateEvent(NULL, TRUE , FALSE, NULL);
}

CThread::~CThread()
{
    if ( hTerminate  == INVALID_HANDLE_VALUE ) CloseHandle(hTerminate);    
    if ( hTerminated == INVALID_HANDLE_VALUE ) CloseHandle(hTerminated);   

    hTerminate  = INVALID_HANDLE_VALUE;
    hTerminated = INVALID_HANDLE_VALUE;
}

int CThread::get_ID()
{ 
    // возврат ID потока
    return fThread_id;
}

// посчет количества "своих" ID в контейнере
int CThread::get_count_IDs()
{ 
    int res = 0;
    int depth = pCBuffer->get_BufferDepth();

    for ( int i = 0; i < depth; i++)
        if ( pCBuffer->get_Value(i) == fThread_id ) res++;

    return res;
}

// Возвращает значения Sleep которое исользовалось в потоке
int CThread::get_SleepValue()
{
    return fSleepValue;
}

// Возвращает число циклов потока
int CThread::get_count_Thread_hits_Number()
{
    return fThread_hits_Number;
}


void CThread::Start()
{
    // Если по какойто причине Ивенты не созданы, поток не запускаю 
    if ( hTerminate  == INVALID_HANDLE_VALUE ) return;
    if ( hTerminated == INVALID_HANDLE_VALUE ) return;

    // счетчик циклов потока
    fThread_hits_Number = 0;

    // Запуск потока
    isThreadStarted = ( _beginthread( ThreadProc, 0, (void *)this ) != 0 ) ? true : false;

    if ( isThreadStarted == false )
        __asm nop;

}

void CThread::Stop()
{
    // Если Ивенты не созданы, нечего останавливать
    if ( hTerminate  == INVALID_HANDLE_VALUE ) return;
    if ( hTerminated == INVALID_HANDLE_VALUE ) return;
    if ( isThreadStarted == false ) return;

    // Подымаю Ивент, указывающий потоку завершить работу
    SetEvent(hTerminate);

    // Жду события завершение потока
    if ( WaitForSingleObject( hTerminated, 500) == WAIT_TIMEOUT )
    {
        //Something wrong
    };

    isThreadStarted = false;
}

void CThread::ThreadProc(void *param)
{
    CThread *thread = (CThread *)param;

    int CBufferDepth = thread->pCBuffer->get_BufferDepth();

    //while( WaitForSingleObject( thread->hTerminate, thread->fSleepValue) == WAIT_TIMEOUT )
    while( WaitForSingleObject( thread->hTerminate, 0) == WAIT_TIMEOUT )
    {
        thread->fThread_hits_Number++;

        // Ожидания собития, можно ли пользоваться контейнером
        WaitForSingleObject( thread->hCanPushValue, INFINITE );

            // 1. Удаляю первый чужой ID (чужой = 1...Y, если ноль ... значит не проиничен еще),
            for ( int i = 1; i <= CBufferDepth; i++)
            {
                int value = thread->pCBuffer->get_Value(i);
                if ( value == 0 ) continue;
                if ( value != thread->fThread_id)
                    // Если найшли ID чужого потока обнуляем
                    thread->pCBuffer->set_Value(i, 0);
                    break;
            }
            // 2. в конец контейнера пишу ID текущего потока
            thread->pCBuffer->Push(thread->fThread_id);

            // В предыдущей версии была реализация, которая ниже
            // но после понимания того, что в контейнер может быть длинной несколько гигабайт
            // пришлось переходить на реализацию кольцеввого буфера, чтобы не "гонять память"
            // ..................
            //// 1. Удаляю первый чужой ID (чужой = 1...Y, если ноль ... значит не проиниче еще),
            //for ( int i = 0; i < thread->fContainer_depth; i++)
            //{
            //    if ( thread->fpContainer[i] == 0 ) continue;
            //    if ( thread->fpContainer[i] != thread->fThread_id)
            //        // Если найшли ID чужого потока обнуляем
            //        thread->fpContainer[i] = 0;
            //        break;
            //}
            //// 2. двигаю контейнер на один элемент влево, 
            //memmove(thread->fpContainer, &thread->fpContainer[1], bytes_for_move);
            //// 3. в конец контейнера пишу ID текущего потока
            //thread->fpContainer[thread->fContainer_depth - 1] = thread->fThread_id;


        // Разрешение работы с контейнером            
        SetEvent(thread->hCanPushValue);
    }
    //std::cout << counter;

    // Устанавливаю событие, что поток удален 
    SetEvent(thread->hTerminated);

    _endthread();
}


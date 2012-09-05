#ifndef _DELEGATE__INC_
#define _DELEGATE__INC_

class IDelegate
{
public:
    virtual ~IDelegate() {}
    
    virtual void operator() () = 0;
};

class StaticDelegate : public IDelegate
{
private:
    typedef void (*PMethod)();

    PMethod method;

public:
    StaticDelegate(PMethod pMethod) { method = pMethod; }

    virtual void operator() () { return method(); }
};

template<class TObject> class ObjectDelegate : public IDelegate
{
private:
    typedef void (TObject::*PMethod)();

    TObject *object;
    PMethod method;

public:
    ObjectDelegate(TObject* pObj, PMethod pMethod)
    {
        object = pObj;
        method = pMethod;
    }

    virtual void operator() () { return (object->*method)(); }
};

class MultyCastDelegate
{
private:
    IDelegate* pDelegate;

public:
    MultyCastDelegate(IDelegate* del = NULL)
    {
        pDelegate = del;
    }

    bool IsNull() { return (pDelegate == NULL); }

    MultyCastDelegate& operator = (IDelegate* del)
    {
        pDelegate = del;
        return *this;
    }

    MultyCastDelegate& operator += (IDelegate* del)
    {
        pDelegate = del;
        return *this;
    }

    void operator()()
    {
        return (*pDelegate)();
    }
};

template<class TObject> IDelegate* NewDelegate(TObject* pObj, void (TObject::*pMethod)())
{
    return new ObjectDelegate<TObject>(pObj, pMethod);
}
inline IDelegate* NewDelegate(void (* pMethod)())
{
    return new StaticDelegate(pMethod);
}

#endif
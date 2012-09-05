/********************************************************************
Этот модуль распространяется с библиотекой
********************************************************************/

#ifndef AP_H
#define AP_H

#include <stdlib.h>
#include <math.h>

/********************************************************************
Режим проверки границ массивов.
********************************************************************/
//#define NO_AP_ASSERT
//#define AP_ASSERT

#ifndef AP_ASSERT
#define NO_AP_ASSERT
#endif

#ifdef NO_AP_ASSERT
#ifdef AP_ASSERT
#undef NO_AP_ASSERT
#endif
#endif


/********************************************************************
Этот символ используется для отладочных целей.

Не определяйте его и не убирайте комментарии!
********************************************************************/
//#define UNSAFE_MEM_COPY


/********************************************************************
Пространство имен стандартной библиотеки AlgoPascal
********************************************************************/
namespace ap
{


/********************************************************************
КЛАСС ИСКЛЮЧЕНИЯ
********************************************************************/
class ap_error
{
public:
    static void make_assertion(bool bClause)
        { if(!bClause) throw ap_error(); };
private:
};

/********************************************************************
Класс, задающий комплексное число двойной точности.
********************************************************************/
class complex;
const complex operator/(const complex& lhs, const complex& rhs);

class complex
{
public:
    complex():x(0.0),y(0.0){};
    complex(const float &_x):x(_x),y(0.0){};
    complex(const float &_x, const float &_y):x(_x),y(_y){};
    complex(const complex &z):x(z.x),y(z.y){};

    complex& operator= (const float& v){ x  = v; y = 0.0; return *this; };
    complex& operator+=(const float& v){ x += v;          return *this; };
    complex& operator-=(const float& v){ x -= v;          return *this; };
    complex& operator*=(const float& v){ x *= v; y *= v;  return *this; };
    complex& operator/=(const float& v){ x /= v; y /= v;  return *this; };

    complex& operator= (const complex& z){ x  = z.x; y  = z.y; return *this; };
    complex& operator+=(const complex& z){ x += z.x; y += z.y; return *this; };
    complex& operator-=(const complex& z){ x -= z.x; y -= z.y; return *this; };
    complex& operator*=(const complex& z){ float t = x*z.x-y*z.y; y = x*z.y+y*z.x; x = t; return *this; };
    complex& operator/=(const complex& z){ (*this) = (*this)/z; return *this; };

    float x, y;
};

const bool operator==(const complex& lhs, const complex& rhs)
{ return lhs.x==rhs.x && lhs.y==rhs.y; }

const bool operator!=(const complex& lhs, const complex& rhs)
{ return lhs.x!=rhs.x || lhs.y!=rhs.y; }

const complex operator+(const complex& lhs)
{ return lhs; }

const complex operator-(const complex& lhs)
{ return complex(-lhs.x, -lhs.y); }

const complex operator+(const complex& lhs, const complex& rhs)
{ complex r = lhs; r += rhs; return r; }

const complex operator+(const complex& lhs, const float& rhs)
{ complex r = lhs; r += rhs; return r; }

const complex operator+(const float& lhs, const complex& rhs)
{ complex r = rhs; r += lhs; return r; }

const complex operator-(const complex& lhs, const complex& rhs)
{ complex r = lhs; r -= rhs; return r; }

const complex operator-(const complex& lhs, const float& rhs)
{ complex r = lhs; r -= rhs; return r; }

const complex operator-(const float& lhs, const complex& rhs)
{ complex r = lhs; r -= rhs; return r; }

const complex operator*(const complex& lhs, const complex& rhs)
{ return complex(lhs.x*rhs.x - lhs.y*rhs.y,  lhs.x*rhs.y + lhs.y*rhs.x); }

const complex operator*(const complex& lhs, const float& rhs)
{ return complex(lhs.x*rhs,  lhs.y*rhs); }

const complex operator*(const float& lhs, const complex& rhs)
{ return complex(lhs*rhs.x,  lhs*rhs.y); }

const complex operator/(const complex& lhs, const complex& rhs)
{
    complex result;
    float e;
    float f;
    if( fabs(rhs.y)<fabs(rhs.x) )
    {
        e = rhs.y/rhs.x;
        f = rhs.x+rhs.y*e;
        result.x = (lhs.x+lhs.y*e)/f;
        result.y = (lhs.y-lhs.x*e)/f;
    }
    else
    {
        e = rhs.x/rhs.y;
        f = rhs.y+rhs.x*e;
        result.x = (lhs.y+lhs.x*e)/f;
        result.y = (-lhs.x+lhs.y*e)/f;
    }
    return result;
}

const complex operator/(const float& lhs, const complex& rhs)
{
    complex result;
    float e;
    float f;
    if( fabs(rhs.y)<fabs(rhs.x) )
    {
        e = rhs.y/rhs.x;
        f = rhs.x+rhs.y*e;
        result.x = lhs/f;
        result.y = -lhs*e/f;
    }
    else
    {
        e = rhs.x/rhs.y;
        f = rhs.y+rhs.x*e;
        result.x = lhs*e/f;
        result.y = -lhs/f;
    }
    return result;
}

const complex operator/(const complex& lhs, const float& rhs)
{ return complex(lhs.x/rhs, lhs.y/rhs); }

const float abscomplex(const complex &z)
{
    float w;
    float xabs;
    float yabs;
    float v;

    xabs = fabs(z.x);
    yabs = fabs(z.y);
    w = xabs>yabs ? xabs : yabs;
    v = xabs<yabs ? xabs : yabs; 
    if( v==0 )
        return w;
    else
    {
        float t = v/w;
        return w*sqrt(1+t*t);
    }
}

const complex conj(const complex &z)
{ return complex(z.x, -z.y); }

const complex csqr(const complex &z)
{ return complex(z.x*z.x-z.y*z.y, 2*z.x*z.y); }


/********************************************************************
Класс-шаблон, определяющий вектор в памяти.
Используется базовыми подпрограммами линейной алгебры.

Вектор состоит из Length элементов типа T, расположенных с шагом Step
начиная с элемента, заданного указателем Data.

Этот класс поддерживает только константный доступ к вектору, запрещая
изменять его. 
********************************************************************/
template<class T>
class const_raw_vector
{
public:
    const_raw_vector(const T *Data, int Length, int Step):
        pData(const_cast<T*>(Data)),iLength(Length),iStep(Step){};

    const T* GetData() const
    { return pData; };

    int GetLength() const
    { return iLength; };

    int GetStep() const
    { return iStep; };
protected:
    T       *pData;
    int     iLength, iStep;
};


/********************************************************************
Класс-шаблон, определяющий вектор в памяти.
Наследует от const_raw_vector.
Используется базовыми подпрограммами линейной алгебры.

Вектор состоит из Length элементов типа T, расположенных с шагом Step
начиная с элемента, заданного указателем Data.

Этот класс поддерживает произвольный доступ к вектору,  разрешая  как
чтение, так и изменение компонент вектора.
********************************************************************/
template<class T>
class raw_vector : public const_raw_vector<T>
{
public:
    raw_vector(T *Data, int Length, int Step):const_raw_vector<T>(Data, Length, Step){};

    T* GetData()
    { return pData; };
};


/********************************************************************
Скалярное произведение векторов
********************************************************************/
template<class T>
T vdotproduct(const_raw_vector<T> v1, const_raw_vector<T> v2)
{
    ap_error::make_assertion(v1.GetLength()==v2.GetLength());
    if( v1.GetStep()==1 && v2.GetStep()==1 )
    {
        //
        // fast
        //
        T r = 0;
        const T *p1 = v1.GetData();
        const T *p2 = v2.GetData();
        int imax = v1.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            r += (*p1)*(*p2) + p1[1]*p2[1] + p1[2]*p2[2] + p1[3]*p2[3];
            p1+=4;
            p2+=4;
        }
        for(i=0; i<v1.GetLength()%4; i++)
            r += (*(p1++))*(*(p2++));
        return r;
    }
    else
    {
        //
        // general
        //
        int offset11 = v1.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = v2.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T r = 0;
        const T *p1 = v1.GetData();
        const T *p2 = v2.GetData();
        int imax = v1.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            r += (*p1)*(*p2) + p1[offset11]*p2[offset21] + p1[offset12]*p2[offset22] + p1[offset13]*p2[offset23];
            p1+=offset14;
            p2+=offset24;
        }
        for(i=0; i<v1.GetLength()%4; i++)
        {
            r += (*p1)*(*p2);
            p1+=offset11;
            p2+=offset21;
        }
        return r;
    }
}


/********************************************************************
Копирование вектора
********************************************************************/
template<class T>
void vmove(raw_vector<T> vdst, const_raw_vector<T> vsrc)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/2;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 = *p2;
            p1[1] = p2[1];
            p1 += 2;
            p2 += 2;
        }
        if(vdst.GetLength()%2 != 0)
            *p1 = *p2;
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 = *p2;
            p1[offset11] = p2[offset21];
            p1[offset12] = p2[offset22];
            p1[offset13] = p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 = *p2;
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Копирование вектора с умножением на -1
********************************************************************/
template<class T>
void vmoveneg(raw_vector<T> vdst, const_raw_vector<T> vsrc)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/2;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 = -*p2;
            p1[1] = -p2[1];
            p1 += 2;
            p2 += 2;
        }
        if(vdst.GetLength()%2 != 0)
            *p1 = -*p2;
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 = -*p2;
            p1[offset11] = -p2[offset21];
            p1[offset12] = -p2[offset22];
            p1[offset13] = -p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 = -*p2;
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Копирование вектора с умножением на число
********************************************************************/
template<class T, class T2>
void vmove(raw_vector<T> vdst, const_raw_vector<T> vsrc, T2 alpha)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 = alpha*(*p2);
            p1[1] = alpha*p2[1];
            p1[2] = alpha*p2[2];
            p1[3] = alpha*p2[3];
            p1 += 4;
            p2 += 4;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
            *(p1++) = alpha*(*(p2++));
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 = alpha*(*p2);
            p1[offset11] = alpha*p2[offset21];
            p1[offset12] = alpha*p2[offset22];
            p1[offset13] = alpha*p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 = alpha*(*p2);
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Добавление вектора
********************************************************************/
template<class T>
void vadd(raw_vector<T> vdst, const_raw_vector<T> vsrc)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 += *p2;
            p1[1] += p2[1];
            p1[2] += p2[2];
            p1[3] += p2[3];
            p1 += 4;
            p2 += 4;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
            *(p1++) += *(p2++);
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 += *p2;
            p1[offset11] += p2[offset21];
            p1[offset12] += p2[offset22];
            p1[offset13] += p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 += *p2;
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Добавление вектора с умножением на число
********************************************************************/
template<class T, class T2>
void vadd(raw_vector<T> vdst, const_raw_vector<T> vsrc, T2 alpha)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 += alpha*(*p2);
            p1[1] += alpha*p2[1];
            p1[2] += alpha*p2[2];
            p1[3] += alpha*p2[3];
            p1 += 4;
            p2 += 4;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
            *(p1++) += alpha*(*(p2++));
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 += alpha*(*p2);
            p1[offset11] += alpha*p2[offset21];
            p1[offset12] += alpha*p2[offset22];
            p1[offset13] += alpha*p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 += alpha*(*p2);
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Вычитание вектора
********************************************************************/
template<class T>
void vsub(raw_vector<T> vdst, const_raw_vector<T> vsrc)
{
    ap_error::make_assertion(vdst.GetLength()==vsrc.GetLength());
    if( vdst.GetStep()==1 && vsrc.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 -= *p2;
            p1[1] -= p2[1];
            p1[2] -= p2[2];
            p1[3] -= p2[3];
            p1 += 4;
            p2 += 4;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
            *(p1++) -= *(p2++);
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        int offset21 = vsrc.GetStep(), offset22 = 2*offset21, offset23 = 3*offset21, offset24 = 4*offset21;
        T *p1 = vdst.GetData();
        const T *p2 = vsrc.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 -= *p2;
            p1[offset11] -= p2[offset21];
            p1[offset12] -= p2[offset22];
            p1[offset13] -= p2[offset23];
            p1 += offset14;
            p2 += offset24;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 -= *p2;
            p1 += vdst.GetStep();
            p2 += vsrc.GetStep();
        }
        return;
    }
}


/********************************************************************
Вычитание вектора с умножением на число
********************************************************************/
template<class T, class T2>
void vsub(raw_vector<T> vdst, const_raw_vector<T> vsrc, T2 alpha)
{
    vadd(vdst, vsrc, -alpha);
}


/********************************************************************
Умножение вектора
********************************************************************/
template<class T, class T2>
void vmul(raw_vector<T> vdst, T2 alpha)
{
    if( vdst.GetStep()==1 )
    {
        //
        // fast
        //
        T *p1 = vdst.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=imax; i!=0; i--)
        {
            *p1 *= alpha;
            p1[1] *= alpha;
            p1[2] *= alpha;
            p1[3] *= alpha;
            p1 += 4;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
            *(p1++) *= alpha;
        return;
    }
    else
    {
        //
        // general
        //
        int offset11 = vdst.GetStep(), offset12 = 2*offset11, offset13 = 3*offset11, offset14 = 4*offset11;
        T *p1 = vdst.GetData();
        int imax = vdst.GetLength()/4;
        int i;
        for(i=0; i<imax; i++)
        {
            *p1 *= alpha;
            p1[offset11] *= alpha;
            p1[offset12] *= alpha;
            p1[offset13] *= alpha;
            p1 += offset14;
        }
        for(i=0; i<vdst.GetLength()%4; i++)
        {
            *p1 *= alpha;
            p1 += vdst.GetStep();
        }
        return;
    }
}


/********************************************************************
КЛАСС-ШАБЛОН ОДНОМЕРНОГО ДИНАМИЧЕСКОГО МАССИВА
********************************************************************/
template<class T>
class template_1d_array
{
public:
    template_1d_array()
    {
        m_Vec=0;
        m_iVecSize = 0;
    };

    ~template_1d_array()
    {
        if(m_Vec)
            delete[] m_Vec;
    };

    template_1d_array(const template_1d_array &rhs)
    {
        m_iVecSize = rhs.m_iVecSize;
        m_iLow = rhs.m_iLow;
        m_iHigh = rhs.m_iHigh;
        if(rhs.m_Vec)
        {
            m_Vec = new T[m_iVecSize];
            #ifndef UNSAFE_MEM_COPY
            for(int i=0; i<m_iVecSize; i++)
                m_Vec[i] = rhs.m_Vec[i];
            #else
            memcpy(m_Vec, rhs.m_Vec, m_iVecSize*sizeof(T));
            #endif
        }
        else
            m_Vec=0;
    };

    
    const template_1d_array& operator=(const template_1d_array &rhs)
    {
        if( this==&rhs )
            return *this;

        m_iLow = rhs.m_iLow;
        m_iHigh = rhs.m_iHigh;
        m_iVecSize = rhs.m_iVecSize;
        if(m_Vec)
            delete[] m_Vec;
        if(rhs.m_Vec)
        {
            m_Vec = new T[m_iVecSize];
            #ifndef UNSAFE_MEM_COPY
            for(int i=0; i<m_iVecSize; i++)
                m_Vec[i] = rhs.m_Vec[i];
            #else
            memcpy(m_Vec, rhs.m_Vec, m_iVecSize*sizeof(T));
            #endif
        }
        else
            m_Vec=0;
        return *this;
    };

    
    const T& operator()(int i) const
    {
        #ifndef NO_AP_ASSERT
        ap_error::make_assertion(i>=m_iLow && i<=m_iHigh);
        #endif
        return m_Vec[ i-m_iLow ];
    };

    
    T& operator()(int i)
    {
        #ifndef NO_AP_ASSERT
        ap_error::make_assertion(i>=m_iLow && i<=m_iHigh);
        #endif
        return m_Vec[ i-m_iLow ];
    };

    
    void setbounds( int iLow, int iHigh )
    {
        if(m_Vec)
            delete[] m_Vec;
        m_iLow = iLow;
        m_iHigh = iHigh;
        m_iVecSize = iHigh-iLow+1;
        m_Vec = new T[m_iVecSize];
    };

    
    void setcontent( int iLow, int iHigh, const T *pContent )
    {
        setbounds(iLow, iHigh);
        for(int i=iLow; i<=iHigh; i++)
            (*this)(i) = pContent[i-iLow];
    };

    
    T* getcontent()
    {
        return m_Vec;
    };

    const T* getcontent() const
    {
        return m_Vec;
    };

    
    int getlowbound(int iBoundNum = 0) const
    {
        return m_iLow;
    };

    
    int gethighbound(int iBoundNum = 0) const
    {
        return m_iHigh;
    };

    raw_vector<T> getvector(int iStart, int iEnd)
    {
        #ifndef NO_AP_ASSERT
        if( iEnd>=iStart )
            ap_error::make_assertion(m_iLow<=iStart && iEnd<=m_iHigh);
        #endif
        if( iStart>iEnd )
            return raw_vector<T>(0, 0, 1);
        else
            return raw_vector<T>(m_Vec+iStart-m_iLow, iEnd-iStart+1, 1);
    };

    
    const_raw_vector<T> getvector(int iStart, int iEnd) const
    {
        #ifndef NO_AP_ASSERT
        if( iEnd>=iStart )
            ap_error::make_assertion(m_iLow<=iStart && iEnd<=m_iHigh);
        #endif
        if( iStart>iEnd )
            return const_raw_vector<T>(0, 0, 1);
        else
            return const_raw_vector<T>(m_Vec+iStart-m_iLow, iEnd-iStart+1, 1);
    };
private:
    T         *m_Vec;
    long      m_iVecSize;
    long      m_iLow, m_iHigh;
};



/********************************************************************
КЛАСС-ШАБЛОН ДВУХМЕРНОГО ДИНАМИЧЕСКОГО МАССИВА
********************************************************************/
template<class T>
class template_2d_array
{
public:
    template_2d_array()
    {
        m_Vec=0;
        m_iVecSize=0;
    };

    ~template_2d_array()
    {
        if(m_Vec)
            delete[] m_Vec;
    };

    template_2d_array(const template_2d_array &rhs)
    {
        m_iVecSize = rhs.m_iVecSize;
        m_iLow1 = rhs.m_iLow1;
        m_iLow2 = rhs.m_iLow2;
        m_iHigh1 = rhs.m_iHigh1;
        m_iHigh2 = rhs.m_iHigh2;
        m_iConstOffset = rhs.m_iConstOffset;
        m_iLinearMember = rhs.m_iLinearMember;
        if(rhs.m_Vec)
        {
            m_Vec = new T[m_iVecSize];
            #ifndef UNSAFE_MEM_COPY
            for(int i=0; i<m_iVecSize; i++)
                m_Vec[i] = rhs.m_Vec[i];
            #else
            memcpy(m_Vec, rhs.m_Vec, m_iVecSize*sizeof(T));
            #endif
        }
        else
            m_Vec=0;
    };
    const template_2d_array& operator=(const template_2d_array &rhs)
    {
        if( this==&rhs )
            return *this;

        m_iLow1 = rhs.m_iLow1;
        m_iLow2 = rhs.m_iLow2;
        m_iHigh1 = rhs.m_iHigh1;
        m_iHigh2 = rhs.m_iHigh2;
        m_iConstOffset = rhs.m_iConstOffset;
        m_iLinearMember = rhs.m_iLinearMember;
        m_iVecSize = rhs.m_iVecSize;
        if(m_Vec)
            delete[] m_Vec;
        if(rhs.m_Vec)
        {
            m_Vec = new T[m_iVecSize];
            #ifndef UNSAFE_MEM_COPY
            for(int i=0; i<m_iVecSize; i++)
                m_Vec[i] = rhs.m_Vec[i];
            #else
            memcpy(m_Vec, rhs.m_Vec, m_iVecSize*sizeof(T));
            #endif
        }
        else
            m_Vec=0;
        return *this;
    };

    const T& operator()(int i1, int i2) const
    {
        #ifndef NO_AP_ASSERT
        ap_error::make_assertion(i1>=m_iLow1 && i1<=m_iHigh1);
        ap_error::make_assertion(i2>=m_iLow2 && i2<=m_iHigh2);
        #endif
        return m_Vec[ m_iConstOffset + i2 +i1*m_iLinearMember];
    };

    T& operator()(int i1, int i2)
    {
        #ifndef NO_AP_ASSERT
        ap_error::make_assertion(i1>=m_iLow1 && i1<=m_iHigh1);
        ap_error::make_assertion(i2>=m_iLow2 && i2<=m_iHigh2);
        #endif
        return m_Vec[ m_iConstOffset + i2 +i1*m_iLinearMember];
    };

    void setbounds( int iLow1, int iHigh1, int iLow2, int iHigh2 )
    {
        if(m_Vec)
            delete[] m_Vec;
        m_iVecSize = (iHigh1-iLow1+1)*(iHigh2-iLow2+1);
        m_Vec = new T[m_iVecSize];
        m_iLow1  = iLow1;
        m_iHigh1 = iHigh1;
        m_iLow2  = iLow2;
        m_iHigh2 = iHigh2;
        m_iConstOffset = -m_iLow2-m_iLow1*(m_iHigh2-m_iLow2+1);
        m_iLinearMember = (m_iHigh2-m_iLow2+1);
    };

    void setcontent( int iLow1, int iHigh1, int iLow2, int iHigh2, const T *pContent )
    {
        setbounds(iLow1, iHigh1, iLow2, iHigh2);
        for(int i=0; i<m_iVecSize; i++)
            m_Vec[i]=pContent[i];
    };

    T* getcontent()
    {
        return m_Vec;
    };

    const T* getcontent() const
    {
        return m_Vec;
    };

    int getlowbound(int iBoundNum) const
    {
        return iBoundNum==1 ? m_iLow1 : m_iLow2;
    };

    int gethighbound(int iBoundNum) const
    {
        return iBoundNum==1 ? m_iHigh1 : m_iHigh2;
    };

    raw_vector<T> getcolumn(int iColumn, int iRowStart, int iRowEnd)
    {
        #ifndef NO_AP_ASSERT
        if( iRowEnd>=iRowStart )
        {
            ap_error::make_assertion(m_iLow1<=iRowStart && iRowEnd<=m_iHigh1);
            ap_error::make_assertion(m_iLow2<=iColumn && iColumn<=m_iHigh2);
        }
        #endif
        if( iRowStart>iRowEnd )
            return raw_vector<T>(0, 0, 1);
        else
            return raw_vector<T>(&((*this)(iRowStart, iColumn)), iRowEnd-iRowStart+1, m_iLinearMember);
    };

    raw_vector<T> getrow(int iRow, int iColumnStart, int iColumnEnd)
    {
        #ifndef NO_AP_ASSERT
        if( iColumnEnd>=iColumnStart )
        {
            ap_error::make_assertion(m_iLow2<=iColumnStart && iColumnEnd<=m_iHigh2);
            ap_error::make_assertion(m_iLow1<=iRow && iRow<=m_iHigh1);
        }
        #endif
        if( iColumnStart>iColumnEnd )
            return raw_vector<T>(0, 0, 1);
        else
            return raw_vector<T>(&((*this)(iRow, iColumnStart)), iColumnEnd-iColumnStart+1, 1);
    };

    const_raw_vector<T> getcolumn(int iColumn, int iRowStart, int iRowEnd) const
    {
        #ifndef NO_AP_ASSERT
        if( iRowEnd>=iRowStart )
        {
            ap_error::make_assertion(m_iLow1<=iRowStart && iRowEnd<=m_iHigh1);
            ap_error::make_assertion(m_iLow2<=iColumn && iColumn<=m_iHigh2);
        }
        #endif
        if( iRowStart>iRowEnd )
            return const_raw_vector<T>(0, 0, 1);
        else
            return const_raw_vector<T>(&((*this)(iRowStart, iColumn)), iRowEnd-iRowStart+1, m_iLinearMember);
    };

    const_raw_vector<T> getrow(int iRow, int iColumnStart, int iColumnEnd) const
    {
        #ifndef NO_AP_ASSERT
        if( iColumnEnd>=iColumnStart )
        {
            ap_error::make_assertion(m_iLow2<=iColumnStart && iColumnEnd<=m_iHigh2);
            ap_error::make_assertion(m_iLow1<=iRow && iRow<=m_iHigh1);
        }
        #endif
        if( iColumnStart>iColumnEnd )
            return const_raw_vector<T>(0, 0, 1);
        else
            return const_raw_vector<T>(&((*this)(iRow, iColumnStart)), iColumnEnd-iColumnStart+1, 1);
    };
private:
    T           *m_Vec;
    long        m_iVecSize;
    long        m_iLow1, m_iLow2, m_iHigh1, m_iHigh2;
    long        m_iConstOffset, m_iLinearMember;
};


typedef template_1d_array<int>     integer_1d_array;
typedef template_1d_array<float>  real_1d_array;
typedef template_1d_array<complex> complex_1d_array;
typedef template_1d_array<bool>    boolean_1d_array;
typedef template_2d_array<int>     integer_2d_array;
typedef template_2d_array<float>  real_2d_array;
typedef template_2d_array<complex> complex_2d_array;
typedef template_2d_array<bool>    boolean_2d_array;


/********************************************************************
Константы и функции для совместимости с AlgoPascal
********************************************************************/
static float machineepsilon = 5.0e-16f;
static float maxrealnumber  = 1.0e+38f;
static float minrealnumber  = 1.0e-38f;

static int sign(float x)
{
    if( x>0 ) return  1;
    if( x<0 ) return -1;
    return 0;
}

static float randomreal()
{
    int i = rand();
    while(i==RAND_MAX)
        i =rand();
    return float(i)/float(RAND_MAX);
}

static int randominteger(int maxv)
{  return rand()%maxv; }

static float round(float x)
{ return floor(x+0.5f); }

static float trunc(float x)
{ return x>0 ? floor(x) : ceil(x); }

static float pi()
{ return 3.14159265358979323846f; }

static float sqr(float x)
{ return x*x; }

static int maxint(int m1, int m2)
{
    return m1>m2 ? m1 : m2;
}

static int minint(int m1, int m2)
{
    return m1>m2 ? m2 : m1;
}

static float maxreal(float m1, float m2)
{
    return m1>m2 ? m1 : m2;
}

static float minreal(float m1, float m2)
{
    return m1>m2 ? m2 : m1;
}

};//namespace ap

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void symmetricmatrixvectormultiply(const ap::real_2d_array& a,
     bool isupper,
     int i1,
     int i2,
     const ap::real_1d_array& x,
     float alpha,
     ap::real_1d_array& y);
void symmetricrank2update(ap::real_2d_array& a,
     bool isupper,
     int i1,
     int i2,
     const ap::real_1d_array& x,
     const ap::real_1d_array& y,
     ap::real_1d_array& t,
     float alpha);

/*************************************************************************
Умножение подматрицы симметричной матрицы на вектор.

Алгоритм умножает подматрицу симметричной матрицы A, заданной верхним или
нижним треугольником, на вектор (справа):

y = alpha*A*x

Входные параметры:
    A   -   матрица. Массив с нумерацией элементов как минимум  от  I1  до
            I2 по обеим размерностям.
    IsUpper-формат хранения (верхний или нижний треугольник).
    I1  -   первые столбец и строка начподматрицы
    I2  -   последние столбец и строка начподматрицы
    X   -   вектор. Массив с нумерацией элементов [1..I2-I1+1]
    Alpha-  скалярный множитель
    Y   -   заранее размещенный в памяти массив
            с нумерацией элементов [1..I2-I1+1].

Выходные параметры:
    Y   -   результат. Массив с нумерацией элементов [1..I2-I1+1]
*************************************************************************/
void symmetricmatrixvectormultiply(const ap::real_2d_array& a,
     bool isupper,
     int i1,
     int i2,
     const ap::real_1d_array& x,
     float alpha,
     ap::real_1d_array& y)
{
    int i;
    int iv;
    int ivm1;
    int ivp1;
    int im1;
    int ip1;
    int n;
    float v;

    n = i2-i1+1;
    if( n<=0 )
    {
        return;
    }
    for(i = i1; i <= i2; i++)
    {
        iv = i-i1+1;
        ivm1 = iv-1;
        ivp1 = iv+1;
        im1 = i-1;
        ip1 = i+1;
        y(iv) = a(i,i)*x(iv);
        if( i>i1 )
        {
            if( isupper )
            {
                v = ap::vdotproduct(a.getcolumn(i, i1, im1), x.getvector(1, ivm1));
            }
            else
            {
                v = ap::vdotproduct(a.getrow(i, i1, im1), x.getvector(1, ivm1));
            }
            y(iv) = y(iv)+v;
        }
        if( i<i2 )
        {
            if( isupper )
            {
                v = ap::vdotproduct(a.getrow(i, ip1, i2), x.getvector(ivp1, n));
            }
            else
            {
                v = ap::vdotproduct(a.getcolumn(i, ip1, i2), x.getvector(ivp1, n));
            }
            y(iv) = y(iv)+v;
        }
    }
    ap::vmul(y.getvector(1, n), alpha);
}


/*************************************************************************
Симметричное обновление ранга 2

Алгоритм осуществляет следующую операцию с симметричной матрецей A:

A = alpha*x*y' + alpha*y*x' + A

Входные параметры:
    A   -   матрица. Массив с нумерацией элементов как минимум  от  I1  до
            I2 по обеим размерностям.
    IsUpper-формат хранения (верхний или нижний треугольник).
    I1  -   первые столбец и строка подматрицы
    I2  -   последние столбец и строка подматрицы
    X   -   вектор. Массив с нумерацией элементов [1..I2-I1+1]
    Y   -   вектор. Массив с нумерацией элементов [1..I2-I1+1]
    T   -   временный массив с нумерацией элементов [1..I2-I1+1], заранее
            размещенный в памяти. модифицируется подпрограммой.
    Alpha-  скалярный множитель

Выходные параметры:
    A   -   модифициованная матрица
*************************************************************************/
void symmetricrank2update(ap::real_2d_array& a,
     bool isupper,
     int i1,
     int i2,
     const ap::real_1d_array& x,
     const ap::real_1d_array& y,
     ap::real_1d_array& t,
     float alpha)
{
    int i;
    int tp1;
    int tp2;
    float v;

    if( isupper )
    {
        for(i = i1; i <= i2; i++)
        {
            tp1 = i+1-i1;
            tp2 = i2-i1+1;
            v = x(i+1-i1);
            ap::vmove(t.getvector(tp1, tp2), y.getvector(tp1, tp2), v);
            v = y(i+1-i1);
            ap::vadd(t.getvector(tp1, tp2), x.getvector(tp1, tp2), v);
            ap::vmul(t.getvector(tp1, tp2), alpha);
            ap::vadd(a.getrow(i, i, i2), t.getvector(tp1, tp2));
        }
    }
    else
    {
        for(i = i1; i <= i2; i++)
        {
            tp1 = 1;
            tp2 = i+1-i1;
            v = x(i+1-i1);
            ap::vmove(t.getvector(tp1, tp2), y.getvector(tp1, tp2), v);
            v = y(i+1-i1);
            ap::vadd(t.getvector(tp1, tp2), x.getvector(tp1, tp2), v);
            ap::vmul(t.getvector(tp1, tp2), alpha);
            ap::vadd(a.getrow(i, i1, i), t.getvector(tp1, tp2));
        }
    }
}



void ldltdecomposition(ap::real_2d_array& a,
     int n,
     bool isupper,
     ap::integer_1d_array& pivots);

/*************************************************************************
LDL^T разложение симметричной матрицы

Алгоритм представляет симметричную матрицу  (не  обязательно  положительно
определенную) в виде  A = L*D*L'  или  A = U*D*U', где матрица D - блочно-
диагональная с блоками  размером  1x1  или  2x2,  матрица  L  (матрица  U)
- произведение нижнетреугольных  (верхнетреугольных)  матриц  с  единичной
диагональю и матриц перестановок.

Входные параметры:
    A   -   факторизуемая матрица. Массив с нумерацией элементов [1..N, 1..N].
            Если IsUpper=True, то в верхнем треугольнике находятся элементы
            симметричной матрицы A, а нижний  треугольник не  используется
            (аналогично, если IsUpper=False).
    N   -   размер факторизуемой матрицы
    IsUpper-параметр, указывающий  способ  задания  матрицы  (верхним  или
            нижним треугольником).
            
Выходные параметры:
    A   -   матрицы D и U, если IsUpper=True, или L, если IsUpper=False, в
            компактной  форме,  замещающие  верхний  (нижний)  треугольник
            матрицы A. При этом элементы, расположенные ниже (выше) главной
            диагонали не используются и не модифицируются.
    Pivots- таблица произведенных перестановок (см. ниже).


    
Если IsUpper=True, то A = U*D*U', U=P(n)*U(n)*...*P(k)*U(k),  где  матрица
P(k) - матрица перестановок, матрица U(k) - верхнетреугольная с  единичной
диагональю, а индекс k уменьшается, начиная с n, с шагом s равным 1 или  2
(согласно размерам блоков матрицы D).

        (   I    v    0   )   k-s
U(k) =  (   0    I    0   )   s
        (   0    0    I   )   n-k
           k-s   s   n-k

Если Pivots[k]>0, то s=1, P(k) - перестановка строк k и Pivots[k],  вектор
v,  формирующий  матрицу  U(k),  хранится  в  элементах  A(1:k-1,k),  D(k)
замещает A(k,k). Если Pivots[k]=Pivots[k-1]<0, то s=2, P(k) - перестановка
строк k-1 и -Pivots[k-1], вектор v, формирующий матрицу  U(k), хранится  в
A(1:k-2,k-1:k), верхний треугольник блока  D(k)  хранится  в   A(k-1,k-1),
A(k-1,k) и A(k,k).



Если IsUpper=False, то A = L*D*L', L=P(1)*L(1)*...*P(k)*L(k),  где  матрица
P(k) - матрица перестановок, матрица L(k) - нижнетреугольная  с  единичной
диагональю, а индекс k растет, начиная с 1, с  шагом  s  равным  1  или  2
(согласно размерам блоков матрицы D).

        (   I    0     0   )  k-1
L(k) =  (   0    I     0   )  s
        (   0    v     I   )  n-k-s+1
           k-1   s  n-k-s+1

Если Pivots[k]>0, то s=1, P(k) - перестановка строк k и Pivots[k],  вектор
v,  формирующий  матрицу  L(k),  хранится  в  элементах  A(k+1:n,k),  D(k)
замещает A(k,k). Если Pivots[k]=Pivots[k+1]<0, то s=2, P(k) - перестановка
строк k+1 и -Pivots[k+1], вектор v, формирующий матрицу  L(k), хранится  в
A(k+2:n,k:k+1), нижний треугольник блока  D(k)  хранится  в A(k,k), A(k+1,k)
и A(k+1,k+1).



  -- LAPACK routine (version 3.0) --
     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
     Courant Institute, Argonne National Lab, and Rice University
     June 30, 1999
*************************************************************************/
void ldltdecomposition(ap::real_2d_array& a,
     int n,
     bool isupper,
     ap::integer_1d_array& pivots)
{
    int i;
    int imax;
    int j;
    int jmax;
    int k;
    int kk;
    int kp;
    int kstep;
    float absakk;
    float alpha;
    float colmax;
    float d11;
    float d12;
    float d21;
    float d22;
    float r1;
    float rowmax;
    float t;
    float wk;
    float wkm1;
    float wkp1;
    int ii;
    int i1;
    int i2;
    float vv;
    ap::real_1d_array temp;

    pivots.setbounds(1, n);
    temp.setbounds(1, n);
    alpha = (1+sqrt(float(17)))/8;
    if( isupper )
    {
        k = n;
        while(k>=1)
        {
            kstep = 1;
            absakk = fabs(a(k,k));
            if( k>1 )
            {
                imax = 1;
                for(ii = 2; ii <= k-1; ii++)
                {
                    if( fabs(a(ii,k))>fabs(a(imax,k)) )
                    {
                        imax = ii;
                    }
                }
                colmax = fabs(a(imax,k));
            }
            else
            {
                colmax = 0;
            }
            if( ap::maxreal(absakk, colmax)==0 )
            {
                kp = k;
            }
            else
            {
                if( absakk>=alpha*colmax )
                {
                    kp = k;
                }
                else
                {
                    jmax = imax+1;
                    for(ii = imax+2; ii <= k; ii++)
                    {
                        if( fabs(a(imax,ii))>fabs(a(imax,jmax)) )
                        {
                            jmax = ii;
                        }
                    }
                    rowmax = fabs(a(imax,jmax));
                    if( imax>1 )
                    {
                        jmax = 1;
                        for(ii = 2; ii <= imax-1; ii++)
                        {
                            if( fabs(a(ii,imax))>fabs(a(jmax,imax)) )
                            {
                                jmax = ii;
                            }
                        }
                        rowmax = ap::maxreal(rowmax, fabs(a(jmax,imax)));
                    }
                    vv = colmax/rowmax;
                    if( absakk>=alpha*colmax*vv )
                    {
                        kp = k;
                    }
                    else
                    {
                        if( fabs(a(imax,imax))>=alpha*rowmax )
                        {
                            kp = imax;
                        }
                        else
                        {
                            kp = imax;
                            kstep = 2;
                        }
                    }
                }
                kk = k-kstep+1;
                if( kp!=kk )
                {
                    i1 = kp-1;
                    ap::vmove(temp.getvector(1, i1), a.getcolumn(kk, 1, i1));
                    ap::vmove(a.getcolumn(kk, 1, i1), a.getcolumn(kp, 1, i1));
                    ap::vmove(a.getcolumn(kp, 1, i1), temp.getvector(1, i1));
                    i1 = kp+1;
                    i2 = kk-1;
                    ap::vmove(temp.getvector(i1, i2), a.getcolumn(kk, i1, i2));
                    ap::vmove(a.getcolumn(kk, i1, i2), a.getrow(kp, i1, i2));
                    ap::vmove(a.getrow(kp, i1, i2), temp.getvector(i1, i2));
                    t = a(kk,kk);
                    a(kk,kk) = a(kp,kp);
                    a(kp,kp) = t;
                    if( kstep==2 )
                    {
                        t = a(k-1,k);
                        a(k-1,k) = a(kp,k);
                        a(kp,k) = t;
                    }
                }
                if( kstep==1 )
                {
                    r1 = 1/a(k,k);
                    for(i = 1; i <= k-1; i++)
                    {
                        i2 = k-1;
                        vv = -r1*a(i,k);
                        ap::vadd(a.getrow(i, i, i2), a.getcolumn(k, i, i2), vv);
                    }
                    i2 = k-1;
                    ap::vmul(a.getcolumn(k, 1, i2), r1);
                }
                else
                {
                    if( k>2 )
                    {
                        d12 = a(k-1,k);
                        d22 = a(k-1,k-1)/d12;
                        d11 = a(k,k)/d12;
                        t = 1/(d11*d22-1);
                        d12 = t/d12;
                        for(j = k-2; j >= 1; j--)
                        {
                            wkm1 = d12*(d11*a(j,k-1)-a(j,k));
                            wk = d12*(d22*a(j,k)-a(j,k-1));
                            ap::vsub(a.getcolumn(j, 1, j), a.getcolumn(k, 1, j), wk);
                            i1 = k-1;
                            ap::vsub(a.getcolumn(j, 1, j), a.getcolumn(i1, 1, j), wkm1);
                            a(j,k) = wk;
                            a(j,k-1) = wkm1;
                        }
                    }
                }
            }
            if( kstep==1 )
            {
                pivots(k) = kp;
            }
            else
            {
                pivots(k) = -kp;
                pivots(k-1) = -kp;
            }
            k = k-kstep;
        }
    }
    else
    {
        k = 1;
        while(k<=n)
        {
            kstep = 1;
            absakk = fabs(a(k,k));
            if( k<n )
            {
                imax = k+1;
                for(ii = k+2; ii <= n; ii++)
                {
                    if( fabs(a(ii,k))>fabs(a(imax,k)) )
                    {
                        imax = ii;
                    }
                }
                colmax = fabs(a(imax,k));
            }
            else
            {
                colmax = 0;
            }
            if( ap::maxreal(absakk, colmax)==0 )
            {
                kp = k;
            }
            else
            {
                if( absakk>=alpha*colmax )
                {
                    kp = k;
                }
                else
                {
                    jmax = k;
                    for(ii = k+1; ii <= imax-1; ii++)
                    {
                        if( fabs(a(imax,ii))>fabs(a(imax,jmax)) )
                        {
                            jmax = ii;
                        }
                    }
                    rowmax = fabs(a(imax,jmax));
                    if( imax<n )
                    {
                        jmax = imax+1;
                        for(ii = imax+2; ii <= n; ii++)
                        {
                            if( fabs(a(ii,imax))>fabs(a(jmax,imax)) )
                            {
                                jmax = ii;
                            }
                        }
                        rowmax = ap::maxreal(rowmax, fabs(a(jmax,imax)));
                    }
                    vv = colmax/rowmax;
                    if( absakk>=alpha*colmax*vv )
                    {
                        kp = k;
                    }
                    else
                    {
                        if( fabs(a(imax,imax))>=alpha*rowmax )
                        {
                            kp = imax;
                        }
                        else
                        {
                            kp = imax;
                            kstep = 2;
                        }
                    }
                }
                kk = k+kstep-1;
                if( kp!=kk )
                {
                    if( kp<n )
                    {
                        i1 = kp+1;
                        ap::vmove(temp.getvector(i1, n), a.getcolumn(kk, i1, n));
                        ap::vmove(a.getcolumn(kk, i1, n), a.getcolumn(kp, i1, n));
                        ap::vmove(a.getcolumn(kp, i1, n), temp.getvector(i1, n));
                    }
                    i1 = kk+1;
                    i2 = kp-1;
                    ap::vmove(temp.getvector(i1, i2), a.getcolumn(kk, i1, i2));
                    ap::vmove(a.getcolumn(kk, i1, i2), a.getrow(kp, i1, i2));
                    ap::vmove(a.getrow(kp, i1, i2), temp.getvector(i1, i2));
                    t = a(kk,kk);
                    a(kk,kk) = a(kp,kp);
                    a(kp,kp) = t;
                    if( kstep==2 )
                    {
                        t = a(k+1,k);
                        a(k+1,k) = a(kp,k);
                        a(kp,k) = t;
                    }
                }
                if( kstep==1 )
                {
                    if( k<n )
                    {
                        d11 = 1/a(k,k);
                        for(ii = k+1; ii <= n; ii++)
                        {
                            i1 = k+1;
                            i2 = ii;
                            vv = -d11*a(ii,k);
                            ap::vadd(a.getrow(ii, i1, i2), a.getcolumn(k, i1, i2), vv);
                        }
                        i1 = k+1;
                        ap::vmul(a.getcolumn(k, i1, n), d11);
                    }
                }
                else
                {
                    if( k<n-1 )
                    {
                        d21 = a(k+1,k);
                        d11 = a(k+1,k+1)/d21;
                        d22 = a(k,k)/d21;
                        t = 1/(d11*d22-1);
                        d21 = t/d21;
                        for(j = k+2; j <= n; j++)
                        {
                            wk = d21*(d11*a(j,k)-a(j,k+1));
                            wkp1 = d21*(d22*a(j,k+1)-a(j,k));
                            ii = k+1;
                            ap::vsub(a.getcolumn(j, j, n), a.getcolumn(k, j, n), wk);
                            ap::vsub(a.getcolumn(j, j, n), a.getcolumn(ii, j, n), wkp1);
                            a(j,k) = wk;
                            a(j,k+1) = wkp1;
                        }
                    }
                }
            }
            if( kstep==1 )
            {
                pivots(k) = kp;
            }
            else
            {
                pivots(k) = -kp;
                pivots(k+1) = -kp;
            }
            k = k+kstep;
        }
    }
}



/*-----------------------------------------------
Эти подпрограммы должен определить программист:

void symmetricmatrixvectormultiply(ap::real_2d_array& a,
     bool isupper,
     int i1,
     int i2,
     const ap::real_1d_array& x,
     float alpha,
     ap::real_1d_array& y);
void ldltdecomposition(ap::real_2d_array& a,
     int n,
     bool isupper,
     ap::integer_1d_array& pivots);
-----------------------------------------------*/

bool inverseldlt(ap::real_2d_array& a,
     const ap::integer_1d_array& pivots,
     int n,
     bool isupper);
bool inversesymmetricindefinite(ap::real_2d_array& a, int n, bool isupper);

/*************************************************************************
Обращение симметричной знаконеопределенной матрицы.

Алгоритм принимает на входе результат LDLT-разложения симметричной матрицы
и строит по нему матрицу A^-1, сохраняя  верхний  или  нижний  треугольник
обратной матрицы в зависимости  от  того,  какой  вариант  LDLT-разложения
(U*D*U' или L*D*L') подается на входе.

Входные параметры:
    A   -   LDLT-разложение обращаемой матрицы.
            Результат работы LDLTDecomposition.
    N   -   размер матрицы
    IsUpper-формат хранения. Если IsUpper=True,  то  симметричная  матрица
            задана разложением в виде A = U*D*U' и её разложение  хранится
            в верхнем треугольнике матрицы A и  на  главной  диагонали,  а
            нижняя часть матрицы A не используется.
    Pivots- таблица перестановок.
            Результат работы подпрограммы LDLTDecomposition.
            
Выходные параметры:
    A   -   матрица, обратная к матрице, LDLT-разложение которой хранилось
            в матрице A на входе в  подпрограмму.
            Массив с нумерацией элементов [1..N, 1..N]
            Если  IsUpper=True, то переменная содержит верхний треугольник
            матрицы A^-1, а элементы расположенные ниже главной  диагонали
            не используются и не изменяются.
            Аналогично, если IsUpper=False.

Результат:
    True, если матрица невырождена.
    False, если матрица вырождена и её обращение невозможно.
    
  -- LAPACK routine (version 3.0) --
     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
     Courant Institute, Argonne National Lab, and Rice University
     March 31, 1993
*************************************************************************/
bool inverseldlt(ap::real_2d_array& a,
     const ap::integer_1d_array& pivots,
     int n,
     bool isupper)
{
    bool result;
    ap::real_1d_array work;
    ap::real_1d_array work2;
    int i;
    int k;
    int kp;
    int kstep;
    float ak;
    float akkp1;
    float akp1;
    float d;
    float t;
    float temp;
    int km1;
    int kp1;
    int l;
    int i1;
    int i2;
    float v;

    work.setbounds(1, n);
    work2.setbounds(1, n);
    result = true;
    if( n==0 )
    {
        return result;
    }
    for(i = 1; i <= n; i++)
    {
        if( pivots(i)>0&&a(i,i)==0 )
        {
            result = false;
            return result;
        }
    }
    if( isupper )
    {
        k = 1;
        while(k<=n)
        {
            if( pivots(k)>0 )
            {
                a(k,k) = 1/a(k,k);
                if( k>1 )
                {
                    km1 = k-1;
                    ap::vmove(work.getvector(1, km1), a.getcolumn(k, 1, km1));
                    symmetricmatrixvectormultiply(a, isupper, 1, k-1, work, float(-1), work2);
                    ap::vmove(a.getcolumn(k, 1, km1), work2.getvector(1, km1));
                    v = ap::vdotproduct(work2.getvector(1, km1), work.getvector(1, km1));
                    a(k,k) = a(k,k)-v;
                }
                kstep = 1;
            }
            else
            {
                t = fabs(a(k,k+1));
                ak = a(k,k)/t;
                akp1 = a(k+1,k+1)/t;
                akkp1 = a(k,k+1)/t;
                d = t*(ak*akp1-1);
                a(k,k) = akp1/d;
                a(k+1,k+1) = ak/d;
                a(k,k+1) = -akkp1/d;
                if( k>1 )
                {
                    km1 = k-1;
                    kp1 = k+1;
                    ap::vmove(work.getvector(1, km1), a.getcolumn(k, 1, km1));
                    symmetricmatrixvectormultiply(a, isupper, 1, k-1, work, float(-1), work2);
                    ap::vmove(a.getcolumn(k, 1, km1), work2.getvector(1, km1));
                    v = ap::vdotproduct(work.getvector(1, km1), work2.getvector(1, km1));
                    a(k,k) = a(k,k)-v;
                    v = ap::vdotproduct(a.getcolumn(k, 1, km1), a.getcolumn(kp1, 1, km1));
                    a(k,k+1) = a(k,k+1)-v;
                    ap::vmove(work.getvector(1, km1), a.getcolumn(kp1, 1, km1));
                    symmetricmatrixvectormultiply(a, isupper, 1, k-1, work, float(-1), work2);
                    ap::vmove(a.getcolumn(kp1, 1, km1), work2.getvector(1, km1));
                    v = ap::vdotproduct(work.getvector(1, km1), work2.getvector(1, km1));
                    a(k+1,k+1) = a(k+1,k+1)-v;
                }
                kstep = 2;
            }
            kp = abs(pivots(k));
            if( kp!=k )
            {
                l = kp-1;
                ap::vmove(work.getvector(1, l), a.getcolumn(k, 1, l));
                ap::vmove(a.getcolumn(k, 1, l), a.getcolumn(kp, 1, l));
                ap::vmove(a.getcolumn(kp, 1, l), work.getvector(1, l));
                l = k-kp-1;
                i1 = kp+1;
                i2 = k-1;
                ap::vmove(work.getvector(1, l), a.getcolumn(k, i1, i2));
                ap::vmove(a.getcolumn(k, i1, i2), a.getrow(kp, i1, i2));
                ap::vmove(a.getrow(kp, i1, i2), work.getvector(1, l));
                temp = a(k,k);
                a(k,k) = a(kp,kp);
                a(kp,kp) = temp;
                if( kstep==2 )
                {
                    temp = a(k,k+1);
                    a(k,k+1) = a(kp,k+1);
                    a(kp,k+1) = temp;
                }
            }
            k = k+kstep;
        }
    }
    else
    {
        k = n;
        while(k>=1)
        {
            if( pivots(k)>0 )
            {
                a(k,k) = 1/a(k,k);
                if( k<n )
                {
                    kp1 = k+1;
                    km1 = k-1;
                    l = n-k;
                    ap::vmove(work.getvector(1, l), a.getcolumn(k, kp1, n));
                    symmetricmatrixvectormultiply(a, isupper, k+1, n, work, float(-1), work2);
                    ap::vmove(a.getcolumn(k, kp1, n), work2.getvector(1, l));
                    v = ap::vdotproduct(work.getvector(1, l), work2.getvector(1, l));
                    a(k,k) = a(k,k)-v;
                }
                kstep = 1;
            }
            else
            {
                t = fabs(a(k,k-1));
                ak = a(k-1,k-1)/t;
                akp1 = a(k,k)/t;
                akkp1 = a(k,k-1)/t;
                d = t*(ak*akp1-1);
                a(k-1,k-1) = akp1/d;
                a(k,k) = ak/d;
                a(k,k-1) = -akkp1/d;
                if( k<n )
                {
                    kp1 = k+1;
                    km1 = k-1;
                    l = n-k;
                    ap::vmove(work.getvector(1, l), a.getcolumn(k, kp1, n));
                    symmetricmatrixvectormultiply(a, isupper, k+1, n, work, float(-1), work2);
                    ap::vmove(a.getcolumn(k, kp1, n), work2.getvector(1, l));
                    v = ap::vdotproduct(work.getvector(1, l), work2.getvector(1, l));
                    a(k,k) = a(k,k)-v;
                    v = ap::vdotproduct(a.getcolumn(k, kp1, n), a.getcolumn(km1, kp1, n));
                    a(k,k-1) = a(k,k-1)-v;
                    ap::vmove(work.getvector(1, l), a.getcolumn(km1, kp1, n));
                    symmetricmatrixvectormultiply(a, isupper, k+1, n, work, float(-1), work2);
                    ap::vmove(a.getcolumn(km1, kp1, n), work2.getvector(1, l));
                    v = ap::vdotproduct(work.getvector(1, l), work2.getvector(1, l));
                    a(k-1,k-1) = a(k-1,k-1)-v;
                }
                kstep = 2;
            }
            kp = abs(pivots(k));
            if( kp!=k )
            {
                if( kp<n )
                {
                    l = n-kp;
                    kp1 = kp+1;
                    ap::vmove(work.getvector(1, l), a.getcolumn(k, kp1, n));
                    ap::vmove(a.getcolumn(k, kp1, n), a.getcolumn(kp, kp1, n));
                    ap::vmove(a.getcolumn(kp, kp1, n), work.getvector(1, l));
                }
                l = kp-k-1;
                i1 = k+1;
                i2 = kp-1;
                ap::vmove(work.getvector(1, l), a.getcolumn(k, i1, i2));
                ap::vmove(a.getcolumn(k, i1, i2), a.getrow(kp, i1, i2));
                ap::vmove(a.getrow(kp, i1, i2), work.getvector(1, l));
                temp = a(k,k);
                a(k,k) = a(kp,kp);
                a(kp,kp) = temp;
                if( kstep==2 )
                {
                    temp = a(k,k-1);
                    a(k,k-1) = a(kp,k-1);
                    a(kp,k-1) = temp;
                }
            }
            k = k-kstep;
        }
    }
    return result;
}


/*************************************************************************
Обращение симметричной знаконеопределенной матрицы.

Алгоритм принимает на входе симметричную матрицу A, заданную  верхним  или
нижним треугольником, и строит по ней матрицу A^-1, сохраняя  верхний  или
нижний  треугольник в зависимости  от того, какая часть матрицы A подается
на входе.

Входные параметры:
    A   -   обращаемая матрица (верхний или нижний треугольник).
            Массив с нумерацией элементов [1..N,1..N]
    N   -   размер матрицы
    IsUpper-формат хранения. Если IsUpper=True, то задан верхний треугольник
            матрицы A, иначе задан нижний треугольник матрицы.

Выходные параметры:
    A   -   матрица, обратная к матрице A.
            Массив с нумерацией элементов [1..N,1..N]
            Если  IsUpper=True, то переменная содержит верхний треугольник
            матрицы A^-1, а элементы расположенные ниже главной  диагонали
            не используются и не изменяются.
            Аналогично, если IsUpper=False.

Результат:
    True, если матрица невырождена.
    False, если матрица вырождена и её обращение невозможно.

  -- LAPACK routine (version 3.0) --
     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
     Courant Institute, Argonne National Lab, and Rice University
     March 31, 1993
*************************************************************************/
bool inversesymmetricindefinite(ap::real_2d_array& a, int n, bool isupper)
{
    bool result;
    ap::integer_1d_array pivots;

    ldltdecomposition(a, n, isupper, pivots);
    result = inverseldlt(a, pivots, n, isupper);
    return result;
}



#endif

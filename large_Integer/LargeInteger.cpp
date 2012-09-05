#include "LargeInteger.h"
#include <iostream>
#include <malloc.h>
#include <string.h>
#include <stdlib.h>

/// <summary>
/// Default constructor for CLargeInteger
/// </summary>
CLargeInteger::CLargeInteger()
{
    // setting default value "0"
    fpchNumber = (char*) calloc (2,1);
    fpchNumber[0]  = '0';
    fSign          = 1;
    fpchNumber_len = 1;

    fpchPrintableVal = 0;
}

/// <summary>
/// Copy constructor for CLargeInteger
/// </summary>
/// <param name="src">Source for coping</param>
CLargeInteger::CLargeInteger( const CLargeInteger &src)
{
    // Sign of value 
    fSign      = src.fSign;

    // Length of new Larget Integer Value
    fpchNumber_len = src.fpchNumber_len;

    // Allocation memory for new Large Integer Value
    fpchNumber = (char*) calloc (fpchNumber_len + 1, 1);
    strcpy(fpchNumber, src.fpchNumber);

    fpchPrintableVal = 0;
}

/// <summary>
/// Constructor with integer initialization
/// </summary>
/// <param name="integer_value">Integer value for the initialization</param>
CLargeInteger::CLargeInteger( const int integer_value )
{
    // convert integer value to char array
    char ch_value[64] = {0};
    char *ptr = _itoa(integer_value, ch_value, 10);

    // Sign check 
    fSign = ( integer_value < 0 ) ? -1    : 1;
    ptr   = ( integer_value < 0 ) ? ++ptr : ptr;
    
    // Copy char array
    fpchNumber_len = strlen(ptr);
    fpchNumber = (char*) calloc (fpchNumber_len + 1, 1);
    strcpy(fpchNumber, ptr);

    // initialization of value for printable array 
    fpchPrintableVal = 0;
}

/// <summary>
/// Constructor with string initialization
/// </summary>
/// <param name="char_values">Char array for the initialization</param>
CLargeInteger::CLargeInteger( const char *char_values)
{
    fpchNumber = (char*) calloc (2,1);
    fpchNumber[0] = '0';
    fSign      = 1;

    // Check is input value is integer
    if ( isIntegerValue( char_values ) == true ) 
    {
        const char *ptr = char_values;

        // Cheack sign
        if ( *ptr == '-' ) {
            fSign = -1;
            ptr++;
        }

        // Copy char array
        fpchNumber_len = strlen(ptr);
        fpchNumber = (char*) realloc ( fpchNumber, fpchNumber_len + 1);
        strcpy(fpchNumber, ptr);    
    }

    // initialization of value for printable array 
    fpchPrintableVal = 0;
}

/// <summary>
/// Default destructor:
/// Cleaning local variables, which used for solving
/// </summary>
CLargeInteger::~CLargeInteger()
{
    // Release of memory
    if ( fpchNumber != 0 )
        free( fpchNumber );

    fpchNumber = 0;

    // Release of memory
    if ( fpchPrintableVal != 0 )
        free( fpchPrintableVal );

    // initialization of value for printable array 
    fpchPrintableVal = 0;
}

/// <summary>
/// Returs is input char array can be integer value
/// </summary>
/// <param name="buff">Char array for checking</param>
/// <returns> <c>true</c>: is value integer </returns>
/// <returns> <c>false</c>: is value not integer  </returns>
bool CLargeInteger::isIntegerValue(const char *buff)
{
    // By default result is true
    bool result = true;

    int buff_len = strlen(buff);

    // Gramma array for checkin is input array is correct
    char gramma[] = "0123456789";

    // First check: Check is first digit is '-'
    const char *ptr = ( buff[0] != '-') ? buff : &buff[1];

    // Second check: is input char attay equal gramma arrya
    while ( *ptr != '\0' && result == true)
    {   
        result = false;
        for ( int i = 0; i < 10; i++ )
            if ( *ptr == gramma[i] ) result = true;
        ptr++;
    }

    // returning result of checking
    return result;
}

/// <summary>
/// Initialization of Integer Value by setting its value to "0"
/// </summary>
void CLargeInteger::Init()
{
    // check, if memory is not allocated
    if ( fpchNumber == NULL ) 
        fpchNumber = (char*) malloc (2);

    // set base values
    fpchNumber[0]  = '0';
    fpchNumber[1]  = '\0';
    fpchNumber_len = 1;
    fSign          = 1;
}

/// <summary>
/// Initialization of Integer Value by Source value
/// </summary>
/// <param name="src"><c>src</c> is a source value of <c>CLargeInteger</c> type for the initialization</param>
void CLargeInteger::Init( const CLargeInteger *src )
{
    // setting values from source value
    fSign          = src->fSign;
    fpchNumber_len = src->fpchNumber_len;

    // allocate memory and copying char array
    fpchNumber = (char*) realloc ( fpchNumber, src->fpchNumber_len + 1);
    strcpy(fpchNumber, src->fpchNumber);
}

/// <summary>
/// Returning of complete value in char array
/// </summary>
/// <returns>Pointer to beginning char string which contains complete integer value</returns>
const char *CLargeInteger::Print()
{
    // Reallocate memory for print char array
    fpchPrintableVal = (char*) realloc (fpchPrintableVal, fpchNumber_len + 5);

    // Sign check
    fpchPrintableVal[0] = ( fSign < 0 ) ? '-' : '0'; 
    int index = ( fSign < 0 ) ? 1 : 0; 

    // Cope zero terminated char array 
    strcpy(&fpchPrintableVal[index], fpchNumber);

    // return result
    return fpchPrintableVal;
}

/// <summary>
/// Add two Large Integer values: res = value1 + value2
/// </summary>
/// <param name="sign1">Sign of value1</param>
/// <param name="len1">Length of value1</param>
/// <param name="pchVal1">Char array of value1</param>
/// <param name="sign2">Sign of value2</param>
/// <param name="len2">Length of value2</param>
/// <param name="pchVal2">Char array of value2</param>
/// <param name="res">The result of the operation</param>
void CLargeInteger::Add( int sign1, int len1, const char *pchVal1, int sign2, int len2, const char *pchVal2, CLargeInteger *res  )
{
    int li1_pos = len1;
    int li2_pos = len2;
    int   result_sign = 1;

    // if value1 < value2, need swap value1 and value2
    if ( Compare( false, sign1, len1, pchVal1, sign2, len2, pchVal2 ) < 0 )
    {
        li1_pos = len2;
        li2_pos = len1;

        const char *c_tmp = pchVal1;
        pchVal1 = pchVal2;
        pchVal2 = c_tmp;

        int i_tmp = sign1;
        sign1 = sign2;
        sign2 = i_tmp;
    }
    if ( sign1 < 0 )
    {
        result_sign = -1;
        sign1 = -sign1;
        sign2 = -sign2;
    }
    
    // Allocate memory for result
    res->fpchNumber_len = ( li1_pos > li2_pos ) ? li1_pos + 1 : li2_pos + 1;
    res->fpchNumber = (char*) realloc(res->fpchNumber, res->fpchNumber_len + 1);

    int val;
    int mem = 0;
    int summ = 0;

    // pointer to last digit
    char *ptr = &res->fpchNumber[res->fpchNumber_len - 1];

    // Main cycle
    for ( int i = 0; i < res->fpchNumber_len; i++, ptr-- )
    {
        char ch1 = ( --li1_pos < 0 ) ? '0' : pchVal1[li1_pos];
        char ch2 = ( --li2_pos < 0 ) ? '0' : pchVal2[li2_pos];

        // The general formula for calculating the new value
        val = sign1*(ch1-48) + sign2*(ch2-48) + mem;
        
        // Determine the value of the "Mind" to the operations of addition and subtraction
        mem = 0;
        if ( val > 9 ) { mem =  1; val -= 10; }
        if ( val < 0 ) { mem = -1; val += 10; }

        // New value, with the transformation in the character CHAR
        *ptr = val + 48; 

        // Sum of the digit, for verification, "the result is = 0"
        summ += val; 
    }

    // Setting sign of operation
    res->fSign = result_sign;

    // Remove "0" values from beginning char array
    ptr = res->fpchNumber;
    while ( *ptr == '0' && *ptr != '\0' ) ptr++; 

    res->fpchNumber_len = res->fpchNumber_len - (ptr - res->fpchNumber);
    memmove(res->fpchNumber, ptr, res->fpchNumber_len);

    // Setting end of string 
    res->fpchNumber[res->fpchNumber_len] = '\0'; // установка конца строки

    // Check summation operation, if '0' then result of summation is "0"
    if ( summ == 0 )
        res->fpchNumber[1] = '\0';
}

/// <summary>
/// Multiply Large Integer value to one digit (0..9): res = value_1 * '0..9'
/// </summary>
/// <param name="len1">Length of value1</param>
/// <param name="pchVal1">Char array of value1</param>
/// <param name="Val2">Value by which we multiply</param>
/// <param name="len_res">Length of result char array</param>
/// <param name="pchRes">Result of operation</param>
void CLargeInteger::Multiply_by_One_digit( int len1, const char *pchVal1, int Val2, int *len_res, char *pchRes )
{
    // If the number by which we multiply is set to "0", then the solution is ready
    if ( Val2 == 0 )
    {
        pchRes[0] = '0';
        pchRes[1] = '\0';
        *len_res  = 1;
        return;
    }

    int mem = 0;
    int val;

    // Pointer to the end of Result
    char *ptr = &pchRes[len1];

    // Main Cycle
    for ( int i = len1-1; i >= 0; i--, ptr-- )
    {
        // Base formula for calculating the new value
        val = (pchVal1[i]-48) * Val2 + mem;
        
        // "mem" holds the increment value for the next operation
        mem = val / 10;

        // New value, with the transformation in the character CHAR
        if ( val > 9 ) 
            *ptr = val%10 + 48; 
        else
            *ptr = val + 48;
    }

    pchRes[0]      = mem + 48; // setting last result of the operation
    pchRes[len1+1] = '\0'; // setting end of line

    //if the result of last operation was less than | 10 |, 
    // then move the whole sequence by one position to the left, 
    //or set the value to 1.    
    if ( val < 10 )
    {
        memmove(pchRes, &pchRes[1], *len_res);
        (*len_res)--;
    }
}

/// <summary>
/// Multiply two Large Integer values: res = value_1 * value_2
/// </summary>
/// <param name="val1">First value of CLargeInteger type</param>
/// <param name="val2">Second value of CLargeInteger type</param>
/// <param name="res">The result of the operation</param>
void CLargeInteger::Multiply( const CLargeInteger *val1, const CLargeInteger *val2, CLargeInteger *res )
{
    int result_sign = val1->fSign * val2->fSign;

    // Allocation temporary memory
    int   new_len = val1->fpchNumber_len + val2->fpchNumber_len;
    char *mul_res  = (char*) malloc ( new_len + 1 );
    char *sum_res  = (char*) malloc ( new_len + 1 );

    // pointer to the last item on the array which makes the multiplication
    char *src_ptr = &val2->fpchNumber[val2->fpchNumber_len-1];  

    // Main cycle
    for ( int i = 0; i < val2->fpchNumber_len; i++, src_ptr-- )
    {
        int mul_len = val1->fpchNumber_len + 1;
        int mul_val = *src_ptr - 48;

        if ( mul_val != 0 )
        {
            // Multiply by one digit
            Multiply_by_One_digit( val1->fpchNumber_len, val1->fpchNumber, mul_val, &mul_len, mul_res);

            // Add "0" to the end of the line
            for ( int k = 0; k < i; k++)
                mul_res[mul_len + k] = '0';
            mul_len += i;
            mul_res[mul_len] = '\0';

            // Summation of result
            strcpy(sum_res, res->fpchNumber);
            Add( 1, strlen(sum_res), sum_res, 1, mul_len, mul_res, res);
        }
    }

    // Setting sign of operation
    res->fSign = result_sign;

    // Release of memory
    free(mul_res);
    free(sum_res);
}

/// <summary>
/// Compare two of Large Integer values (value1, value2), return -1 or 0 or 1 depends of input values
/// </summary>
/// <param name="isSignCheck">is true: Compare values by module, is false: full compare</param>
/// <param name="sign1">Sign of <c>value1</c></param>
/// <param name="len1">Length of char array of <c>value1</c></param>
/// <param name="pchVal1">Char array for Large Integer Value <c>value1</c></param>
/// <param name="sign2">Sign of <c>value2</c></param>
/// <param name="len2">Length of char array of <c>value2</c></param>
/// <param name="pchVal2">Char array for Large Integer Value <c>value2</c></param>
/// <returns> -1 : if value1 less by value2 </returns>
/// <returns>  0 : if value1 equal value2 </returns>
/// <returns>  1 : if value1 greater value2 </returns>
int CLargeInteger::Compare(  bool isSignCheck, int sign1, int len1, const char *pchVal1, int sign2, int len2, const char *pchVal2 )
{
    int sign_val1 = ( isSignCheck ) ? sign1 : 1;
    int sign_val2 = ( isSignCheck ) ? sign2 : 1;

    // Checking the signs of values, if different - a decision is ready
    if ( sign_val1 > sign_val2 ) return  1;
    if ( sign_val1 < sign_val2 ) return -1;

    // if sing of values is equal, checking length of  values, if different - a decision is ready
    if ( len1 > len2 ) return  sign_val1;
    if ( len1 < len2 ) return -sign_val1;

    // if length of values is equal, checking difference of chars
    int res = 0; // by default numbers is equal
    for ( int i = 0; i < len1; i++)
    {
        if ( pchVal1[i] == pchVal2[i] ) continue;
        if ( pchVal1[i] >  pchVal2[i] ) res =  sign_val1;
        if ( pchVal1[i] <  pchVal2[i] ) res = -sign_val1;
    }
    return res;
}

/// <summary>
/// Divide two Large Integer values: res = value1 / value2. 
/// Remark function without exception and return "0" if value2 equal "0".
/// </summary>
/// <param name="li1">First value of CLargeInteger type</param>
/// <param name="li2">Second value of CLargeInteger type</param>
/// <param name="res">The result of the operation</param>
void CLargeInteger::Divide(const CLargeInteger *li1, const CLargeInteger *li2, CLargeInteger *res)
{
    // If li2 <= li2, then the result is equal to "0"
    if ( Compare( false, li1->fSign, li1->fpchNumber_len, li1->fpchNumber, li2->fSign, li2->fpchNumber_len, li2->fpchNumber ) <= 0 )
    {
        res->Init();
        return;
    }
    else
    {
        CLargeInteger tmp1(*li1);
        CLargeInteger tmp2;

        // Allocate temporary memory
        char *sum_res  = (char*) malloc ( li1->fpchNumber_len + 1 );

        int counter = 0;
        // Main Cycle
        while ( true )
        {
            Add( 1, tmp1.fpchNumber_len, tmp1.fpchNumber, 
                -1, li2->fpchNumber_len, li2->fpchNumber, &tmp2);

            if ( tmp2.fSign < 0 ) break;

            tmp1.Init(&tmp2);

            // Summation of result
            strcpy(sum_res, res->fpchNumber);
            Add( 1, strlen(sum_res), sum_res, 1, 1, "1", res);
        }
    }

    // If the signs of the input numbers are not equal, then the result of dividing "-1"
    res->fSign = ( li1->fSign != li2->fSign ) ? -1 : 1;
}

/// <summary>
/// Overloaded operator (=) for assignment value2 to value1: value1 = value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Result of operation value1 equal value2</returns>
CLargeInteger CLargeInteger::operator =  (const CLargeInteger &src)
{
    Init(&src);

    return *this;
}

/// <summary>
/// Overloaded operator (+) for solving the following equation: result = value1 + value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Result of operation</returns>
CLargeInteger CLargeInteger::operator + (const CLargeInteger &src)
{
    CLargeInteger res;

    Add( fSign, fpchNumber_len, fpchNumber, src.fSign, src.fpchNumber_len, src.fpchNumber, &res);

    return res;
}

/// <summary>
/// Overloaded operator (-) for solving the following equation: result = value1 - value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Result of operation</returns>
CLargeInteger CLargeInteger::operator - (const CLargeInteger &src)
{
    CLargeInteger res;

    //AddN( fSign, this, -src.fSign, &src, &res);
    Add( fSign, fpchNumber_len, fpchNumber, -src.fSign, src.fpchNumber_len, src.fpchNumber, &res);

    return res;
}

/// <summary>
/// Overloaded operator (*) for solving the following equation: result = value1 * value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Result of operation</returns>
CLargeInteger CLargeInteger::operator * (const CLargeInteger &src)
{
    CLargeInteger res;

    Multiply( this, &src, &res );

    return res;
}

/// <summary>
/// Overloaded operator (/) for solving the following equation: result = value1 / value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Result of operation</returns>
CLargeInteger CLargeInteger::operator / (const CLargeInteger &src)
{
    CLargeInteger res;

    Divide( this, &src, &res);

    return res;
}

/// <summary>
/// Overloaded operator (+=) for solving the following equation:  value1 += value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Return in the value1 result of operation</returns>
CLargeInteger CLargeInteger::operator += (const CLargeInteger &src)
{
    CLargeInteger tmp(*this);

    Add( tmp.fSign, tmp.fpchNumber_len, tmp.fpchNumber, 
         src.fSign, src.fpchNumber_len, src.fpchNumber, this);

    return *this;
}

/// <summary>
/// Overloaded operator (-=) for solving the following equation:  value1 -= value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Return in the value1 result of operation</returns>
CLargeInteger CLargeInteger::operator -= (const CLargeInteger &src)
{
    CLargeInteger tmp(*this);

    Add( tmp.fSign, tmp.fpchNumber_len, tmp.fpchNumber, 
        -src.fSign, src.fpchNumber_len, src.fpchNumber, this);

    return *this;
}

/// <summary>
/// Overloaded operator (*=) for solving the following equation:  value1 *= value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Return in the value1 result of operation</returns>
CLargeInteger CLargeInteger::operator *= (const CLargeInteger &src)
{
    CLargeInteger tmp(*this);

    Init();
    
    Multiply( &tmp, &src, this );

    return *this;
}

/// <summary>
/// Overloaded operator (/=) for solving the following equation:  value1 /= value2
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Return in the value1 result of operation</returns>
CLargeInteger CLargeInteger::operator /= (const CLargeInteger &src)
{
    CLargeInteger tmp(*this);

    Init();
    
    Divide( &tmp, &src, this);

    return *this;
}

/// <summary>
/// Compare two Large Integer value: bool result = (value1 == value2)
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Retrun <c>true</c> if condition is correct</returns>
bool CLargeInteger::operator == (const CLargeInteger &src)
{
    int res = Compare( true, this->fSign, this->fpchNumber_len, this->fpchNumber, 
                               src.fSign,   src.fpchNumber_len, src.fpchNumber );
    return ( res == 0 );
}

/// <summary>
/// Compare two Large Integer value: bool result = (value1 > value2)
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Retrun <c>true</c> if condition is correct</returns>
bool CLargeInteger::operator >  (const CLargeInteger &src)
{
    int res = Compare( true, this->fSign, this->fpchNumber_len, this->fpchNumber, 
                               src.fSign,   src.fpchNumber_len, src.fpchNumber );
    return ( res > 0 );
}

/// <summary>
/// Compare two Large Integer value: bool result = (value1 >= value2)
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Retrun <c>true</c> if condition is correct</returns>
bool CLargeInteger::operator >= (const CLargeInteger &src)
{
    int res = Compare( true, this->fSign, this->fpchNumber_len, this->fpchNumber, 
                               src.fSign,   src.fpchNumber_len, src.fpchNumber );
    return ( res >= 0 );
}

/// <summary>
/// Compare two Large Integer value: bool result = (value1 < value2)
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Retrun <c>true</c> if condition is correct</returns>
bool CLargeInteger::operator <  (const CLargeInteger &src)
{
    int res = Compare( true, this->fSign, this->fpchNumber_len, this->fpchNumber, 
                               src.fSign,   src.fpchNumber_len, src.fpchNumber );
    return ( res < 0 );
}

/// <summary>
/// Compare two Large Integer value: bool result = (value1 <= value2)
/// </summary>
/// <param name="src">Large Integer value wich represet value2</param>
/// <returns>Retrun <c>true</c> if condition is correct</returns>
bool CLargeInteger::operator <= (const CLargeInteger &src)
{
    int res = Compare( true, this->fSign, this->fpchNumber_len, this->fpchNumber, 
                                src.fSign,   src.fpchNumber_len, src.fpchNumber );
    return ( res <= 0 );
}

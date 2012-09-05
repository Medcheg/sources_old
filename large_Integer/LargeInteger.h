#ifndef LARGE_INTEGER
#define LARGE_INTEGER

/// <summary>
/// <c>LargeInteger</c> class represents interface for solving arithmetic operation with extremely long integer values
/// </summary>
class CLargeInteger
{
private:
    /// <summary>Pointer to char array which store large integer value </summary>
    char *fpchNumber;

    /// <summary>Length of char array which store large integer values</summary>
    int   fpchNumber_len;

    /// <summary>Store sign of integer value</summary>
    int   fSign;

    /// <summary>Pointer to string which contains complete integer value</summary>
    char *fpchPrintableVal; 

    /// <summary>
    /// Initialization of Integer Value by setting its value to "0"
    /// </summary>
    void Init();

    /// <summary>
    /// Initialization of Integer Value by Source value
    /// </summary>
    /// <param name="src"><c>src</c> is a source value of <c>CLargeInteger</c> type for the initialization</param>
    void Init( const CLargeInteger *src );

    /// <summary>
    /// Add two integer values: res = value_1 + value_2
    /// </summary>
    /// <param name="sign1">Sign of value_1</param>
    /// <param name="len1">Length of value_1</param>
    /// <param name="pchVal1">Char array of value_1</param>
    /// <param name="sign2">Sign of value_2</param>
    /// <param name="len2">Length of value_2</param>
    /// <param name="pchVal2">Char array of value_2</param>
    /// <param name="res">The result of the operation</param>
    void Add(  int sign1, int len1, const char *pchVal1, int sign2, int len2, const char *pchVal2, CLargeInteger *res );

    /// <summary>
    /// Multiply Large Integer value to one digit (0..9): res = value_1 * '0..9'
    /// </summary>
    /// <param name="len1">Length of value_1</param>
    /// <param name="pchVal1">Char array of value_1</param>
    /// <param name="Val2">Value by which we multiply</param>
    /// <param name="len_res">Length of result char array</param>
    /// <param name="pchRes">Result of operation</param>
    void Multiply_by_One_digit( int len1, const char *pchVal1, int Val2, int *len_res, char *pchRes );


    /// <summary>
    /// Multiply two Large Integer values: res = value_1 * value_2
    /// </summary>
    /// <param name="val1">First value of CLargeInteger type</param>
    /// <param name="val2">Second value of CLargeInteger type</param>
    /// <param name="res">The result of the operation</param>
    void Multiply( const CLargeInteger *val1, const CLargeInteger *val2, CLargeInteger *res );

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
    int  Compare( bool isSignCheck, int sign1, int len1, const char *pchVal1, int sign2, int len2, const char *pchVal2);
 
    /// <summary>
    /// Divide two Large Integer values: res = value1 / value2. 
    /// Remark function without exception and return "0" if value2 equal "0".
    /// </summary>
    /// <param name="li1">First value of CLargeInteger type</param>
    /// <param name="li2">Second value of CLargeInteger type</param>
    /// <param name="res">The result of the operation</param>
    void Divide(const CLargeInteger *li1, const CLargeInteger *li2, CLargeInteger *res);
public:
    /// <summary>
    /// Default constructor for CLargeInteger
    /// </summary>
    CLargeInteger();

    /// <summary>
    /// Copy constructor for CLargeInteger
    /// </summary>
    /// <param name="src">Source for coping</param>
    CLargeInteger( const CLargeInteger &src  ); 

    /// <summary>
    /// Constructor with integer initialization
    /// </summary>
    /// <param name="integer_value">Integer value for the initialization</param>
    CLargeInteger( const int integer_value);

    /// <summary>
    /// Constructor with string initialization
    /// </summary>
    /// <param name="char_values">Char array for the initialization</param>
    CLargeInteger( const char *_char_values  );

    /// <summary>
    /// Default destructor:
    /// Cleaning local variables, which used for solving
    /// </summary>
    ~CLargeInteger();//////////////////

    /// <summary>
    /// Returs is input char array can be integer value
    /// </summary>
    /// <param name="buff">Char array for checking</param>
    /// <returns> <c>true</c>: is value integer </returns>
    /// <returns> <c>false</c>: is value not integer  </returns>
    static bool isIntegerValue(const char *buff);

    /// <summary>
    /// Returning of complete value in char array
    /// </summary>
    /// <returns>Pointer to beginning char string which contains complete integer value</returns>
    const char *Print();

    /// <summary>
    /// Overloaded operator (=) for assignment value2 to value1: value1 = value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Result of operation value1 equal value2</returns>
    CLargeInteger operator =  (const CLargeInteger &src); 

    /// <summary>
    /// Overloaded operator (+) for solving the following equation: result = value1 + value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Result of operation</returns>
    CLargeInteger operator +  (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (-) for solving the following equation: result = value1 - value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Result of operation</returns>
    CLargeInteger operator -  (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (*) for solving the following equation: result = value1 * value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Result of operation</returns>
    CLargeInteger operator *  (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (/) for solving the following equation: result = value1 / value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Result of operation</returns>
    CLargeInteger operator /  (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (+=) for solving the following equation:  value1 += value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Return in the value1 result of operation</returns>
    CLargeInteger operator += (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (-=) for solving the following equation:  value1 -= value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Return in the value1 result of operation</returns>
    CLargeInteger operator -= (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (*=) for solving the following equation:  value1 *= value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Return in the value1 result of operation</returns>
    CLargeInteger operator *= (const CLargeInteger &src);

    /// <summary>
    /// Overloaded operator (/=) for solving the following equation:  value1 /= value2
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Return in the value1 result of operation</returns>
    CLargeInteger operator /= (const CLargeInteger &src);

    /// <summary>
    /// Compare two Large Integer value: bool result = (value1 == value2)
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Retrun <c>true</c> if condition is correct</returns>
    bool operator == (const CLargeInteger &src);

    /// <summary>
    /// Compare two Large Integer value: bool result = (value1 > value2)
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Retrun <c>true</c> if condition is correct</returns>
    bool operator >  (const CLargeInteger &src);

    /// <summary>
    /// Compare two Large Integer value: bool result = (value1 >= value2)
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Retrun <c>true</c> if condition is correct</returns>
    bool operator >= (const CLargeInteger &src);

    /// <summary>
    /// Compare two Large Integer value: bool result = (value1 < value2)
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Retrun <c>true</c> if condition is correct</returns>
    bool operator <  (const CLargeInteger &src);

    /// <summary>
    /// Compare two Large Integer value: bool result = (value1 <= value2)
    /// </summary>
    /// <param name="src">Large Integer value wich represet value2</param>
    /// <returns>Retrun <c>true</c> if condition is correct</returns>
    bool operator <= (const CLargeInteger &src);
};


#endif
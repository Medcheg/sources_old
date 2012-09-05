#include <iostream>
#include "LargeInteger.h"

void HelpOutput()
{
    CLargeInteger val1 =  "23847623498738874576";
    CLargeInteger val2 =  "-562423498738745872";

    // Base operation
    CLargeInteger i_val1 =  val1 + val2;
    CLargeInteger i_val2 =  val1 - val2;
    CLargeInteger i_val3 =  val1 * val2;
    CLargeInteger i_val4 =  val1 / val2;

    // Logical operation
    bool compare_res1 = ( val1 == val2 );
    bool compare_res2 = ( val1  > val2 );
    bool compare_res3 = ( val1 >= val2 );
    bool compare_res4 = ( val1 <  val2 );
    bool compare_res5 = ( val1 <= val2 );

    // Short help
    std::cout << std::endl;
    std::cout << "LargeInteger.exe [/?] [value1 op value2]\n\n"; 
    std::cout << "value1  : Specifies an integer value 1" << std::endl;
    std::cout << "op      : Type of operation such as +, -, *, /" << std::endl;
    std::cout << "value2  : Specifies an integer value 2" << std::endl;
    std::cout << std::endl;
    std::cout << "Example: LargeInteger.exe 562423498738745872 + 23847623498738874576" << std::endl;
    std::cout << std::endl;

    // Demostration of work
    std::cout << std::endl;
    std::cout << "---------------------------------------------------------" << std::endl;
    std::cout << "|                 Program demonstration                 |" << std::endl;
    std::cout << "---------------------------------------------------------" << std::endl;
    std::cout << std::endl;
    std::cout << "value1 = " << val1.Print() << std::endl;
    std::cout << "value2 = " << val2.Print() << std::endl;

    // Result of base operation
    std::cout << std::endl;
    std::cout << "value1 + value2 = " << i_val1.Print() << std::endl;
    std::cout << "value1 - value2 = " << i_val2.Print() << std::endl;
    std::cout << "value1 * value2 = " << i_val3.Print() << std::endl;
    std::cout << "value1 / value2 = " << i_val4.Print() << std::endl;

    // Result of logical operation
    std::cout << std::endl;
    std::cout << "( value1 == value2 ) = " << ((compare_res1) ? "true" : "false") << std::endl;
    std::cout << "( value1  > value2 ) = " << ((compare_res2) ? "true" : "false") << std::endl;
    std::cout << "( value1 >= value2 ) = " << ((compare_res3) ? "true" : "false") << std::endl;
    std::cout << "( value1 <  value2 ) = " << ((compare_res4) ? "true" : "false") << std::endl;
    std::cout << "( value1 <= value2 ) = " << ((compare_res5) ? "true" : "false") << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
}

int main( int args_count, char **args )
{
    std::cout << std::endl;
    std::cout << "Library for solving equation with Large Integer numbers\n\n";
    
    // convert input arguments to lowercase
    for ( int i = 1; i < args_count; i++) 
    {
        char *ptr = args[i];
        while (*ptr != '\0') *(ptr++) = tolower(*ptr);
    }

    // Output help into Console
    if ( args_count <= 3 )
    {
        HelpOutput();
        return 0;
    }

    // Checking gramma : Integer Value 1
    if ( CLargeInteger::isIntegerValue(args[1]) != true )
    {
        HelpOutput();
        std::cout << "\n\n ERROR: Value1 - non numerical\n";
        return 0;
    }

    // Checking gramma : Operation Type
    int OperationType = 0;
    OperationType = ( *args[2] == '+' ) ? 1 : 0;
    OperationType = ( *args[2] == '-' ) ? 2 : OperationType;
    OperationType = ( *args[2] == '*' ) ? 3 : OperationType;
    OperationType = ( *args[2] == '/' ) ? 4 : OperationType;
    if ( OperationType == 0 )
    {
        HelpOutput();
        std::cout << "\n\n ERROR: wrong operation type\n";
        return 0;
    }

    // Checking gramma : Integer Value 2
    if ( CLargeInteger::isIntegerValue(args[3]) != true )
    {
        HelpOutput();
        std::cout << "\n\n ERROR: Value2 - non numerical\n";
        return 0;
    }

    // Get operation result and exit
    CLargeInteger li1(args[1]);
    CLargeInteger li2(args[3]);
    CLargeInteger result;
    switch ( OperationType )
    {
        case 1 : result = li1 + li2; break;
        case 2 : result = li1 - li2; break;
        case 3 : result = li1 + li2; break;
        case 4 : result = li1 * li2; break;
    }

    std::cout << std::endl;
    std::cout << "value1 = " << li1.Print() << std::endl;
    std::cout << "value2 = " << li2.Print() << std::endl;
    std::cout << std::endl;
    std::cout << "value1 " << args[2] << " value2 = " << result.Print() << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;

    //system("pause");
    return 0;
}
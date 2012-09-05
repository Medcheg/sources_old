#include <stdio.h>
#include <conio.h>


void get_FibonacciNumber(int fibonacciBase)
{
    static int old_result = 1;
    static int result = 1;
    int new_result;

    new_result = result + old_result;
    old_result = result;
    result = new_result;

    // вывод информации 
    static int counter = 1;
    if (counter++ == 1)
        printf("%3i = 1\n", 1);
    printf("%3i = %i\n", counter, result);


    if ( fibonacciBase > 2 ) get_FibonacciNumber( fibonacciBase - 1 );

}

void main()
{
    get_FibonacciNumber(10);

    printf("\n .... Press any key for finish .....");
    _getch();
}
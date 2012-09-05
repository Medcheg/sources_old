#include "stdio.h"
#include "conio.h"
#include "memory.h"
#include "malloc.h"
#include <stdlib.h>
#include <time.h>


int operation_count = 0;

void print_array(int *arr, int len)
{
    for ( int i = 0; i < len; i++)
        printf("%4i ", arr[i]);
    printf("\n");
}

void standart_sort(int arr[], int len)
{
    for ( int i = 0; i < len; i++ )
        for ( int k = i + 1; k < len; k++ )
        {
             if ( arr[i] > arr[k] )
             {
                 int Baloon = arr[i];
                 arr[i]     = arr[k];
                 arr[k]     = Baloon;
             }
             operation_count++;
        }
}

// A - сортируемый массив, n - количество элементов
void stupidSort(int *A, int n)
{
    int i = 0, tmp;
    while (i < n-1)
    {
        if (A[i+1] < A[i])
        {
            tmp = A[i];
            A[i] = A[i+1];
            A[i+1] = tmp;
            i = 0;
            operation_count++;
        }
        else i++;
    }
}

//при первом вызове 2-ой аргумент должен быть равен 0
//3-ий аргумент должен быть равен числу элементов массива минус 1 
void quickSort(int arr[], int left, int right) {
      int l = left, r = right;
      int tmp;
      int pivot = arr[(left + right) / 2];
 
      /* partition */
      while (l <= r) {
            while (arr[l] < pivot) {l++; operation_count++; }
            while (arr[r] > pivot) {r--; operation_count++; }
            if (l <= r) 
            {
                if ( arr[l] != arr[r] )
                {
                    arr[l] = arr[l]^arr[r];
                    arr[r] = arr[l]^arr[r];
                    arr[l] = arr[l]^arr[r];

                    //tmp    = arr[l];
                    //arr[l] = arr[r];
                    //arr[r] = tmp;
                }
                l++;
                r--;
                operation_count++;
                print_array(arr, 6);
            }
      };
 
      /* recursion */
      if (left < r)
            quickSort(arr, left, r);
      if (l < right)
            quickSort(arr, l, right);
}    

void main()
{
    /// создаю случайный масив 
    int len = 6;
    int *base_arr = (int* ) malloc (sizeof(int)*len);
    int *arr      = (int* ) malloc (sizeof(int)*len);

    //srand( (unsigned)time( NULL ) );
    srand( 1343 );

    for ( int i = 0; i < len; i ++)
        base_arr[i] = rand() / 60;

    print_array(base_arr, len); printf("\n");
    
    operation_count = 0;
    memcpy(arr, base_arr, sizeof(int)*len);
    quickSort(arr, 0, len-1);
    printf("quicksort  =%3i : ",operation_count);
    print_array(arr, len);

    // **********
    operation_count = 0;
    memcpy(arr, base_arr, sizeof(int)*len);
    standart_sort(arr, len);
    printf("hz         =%3i : ",operation_count);
    print_array(arr, len);

    // **********
    operation_count = 0;
    memcpy(arr, base_arr, sizeof(int)*len);
    standart_sort(arr, len);
    printf("StupidSort =%3i : ",operation_count);
    print_array(arr, len);


    printf("\n .... Press any key for finish .....");

    _getch();
}
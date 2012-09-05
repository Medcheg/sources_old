using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace pmClasses
{
    class Collection1<T> where T:IComparable<T>
    {
        private  List<T> vals = new List<T>();
        private T max, min;
        private void doSome()
        {
            max = vals[0];
            if (max < vals[1]) max = vals[1];
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using pmClasses;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            List<int> list = new List<int>();
            list.Add(1);
            list.Add(2);
            list.Add(3);

            list[0] = 1;
            list[1] = 2;
            list[2] = 3;


            
            System.Collections.Generic.List<int> asd = new List<int>();
                

            Collection<float> c1 = new Collection<float>();
            Collection<float> c2 = new Collection<float>(5);


            float val = c1.Values;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using pmClasses;

namespace console_01
{
    class Program
    {
        class Sample
        {
            public IEnumerator<int> GetEnumerator()
            {
                for (var i = 0; i < 10; ++i)
                    yield return i;
            }
        }

        class Test1 { public List<List<float>> a; }
        class Test2 { public List<List<float>> a; }
        
        static void Main(string[] args)
        {


            //System.Globalization.CultureInfo.

            Test1 t1 = new Test1();
            Test2 t2 = new Test2();

            t1.a = new List<List<float>>();
            t1.a.Add(new List<float>());
            t1.a.Add(new List<float>());

            t1.a[0].Add(1);
            t1.a[1].Add(2);

            t2.a = t1.a;

            t1.a.Clear();
            t1.a.Add(new List<float>());
            t1.a.Add(new List<float>());
            t1.a[0].Add(11);
            t1.a[1].Add(22);
            //t1.a.Add(2);


            foreach (var t in new Sample())
                Console.WriteLine(t);
            //Console.ReadKey();

            pmClasses.Collection cc = new pmClasses.Collection(5);

            cc.File.Load_TextFile("E:\\#Shared#\\43-219_pasha.exp(002)_s_pr_SF(T).txt"     , null);
            cc.File.Save_TextFile("E:\\#Shared#\\43-219_pasha.exp(002)_s_pr_SF(T)_text.txt", null);
        }
    }
}

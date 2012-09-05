using System;
using System.Collections.Generic;
using System.Text;

namespace pmcore_test
{
    class Program
    {
        static void Main(string[] args)
        {
            int t1 = System.Environment.TickCount;

            // Regression testing
            //pmcore.Collection base_collection = new pmcore.Collection("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            
            pmcore.Collection base_collection = new pmcore.Collection(2);
            base_collection.Add(0,0);  base_collection.Add(1,0);
            base_collection.Add(0,1);  base_collection.Add(1,0.5);
            base_collection.Add(0,2);  base_collection.Add(1,1);

            pmcore.Collection c1 = base_collection.get_SubCollection(new int[]{0});
            pmcore.Collection c2 = base_collection.get_SubCollection(new int[]{1});


            int []power_array = new int[]{0,1};
            double [][]res = pmcore.Math.Regression(c1, c2, power_array);
            for ( int i = 0 ; i < c2.VectorsCount; i++)
            {
                System.Console.WriteLine("");
                for ( int k = 0; k < power_array.Length; k++ )
                    System.Console.Write(res[i][k].ToString("f9") + "\t");
            }

            System.Console.WriteLine("");
            System.Console.WriteLine("");

            // Matrix testing
            double []in_array = {1, 2, 1, 
                                 4, 1, 6, 
                                 1, 2, 3};
            pmcore.Types.Matrix m1 = new pmcore.Types.Matrix(3, 3, in_array);
            pmcore.Types.Matrix m2 = new pmcore.Types.Matrix(m1);
            pmcore.Types.Matrix m3 = m1+m2;
            pmcore.Types.Matrix m4 =  (m1+m2)*(m1+m2);
            pmcore.Types.Matrix m5 = ((m1+m2)*(m1+m2)).Inverse();
            pmcore.Types.Matrix m6 = m4*m5;

            //Console.WriteLine(m1.ToString());
            //Console.WriteLine(m2.ToString());
            Console.WriteLine(m3.ToString());
            Console.WriteLine(m4.ToString());
            Console.WriteLine(m5.ToString());
            Console.WriteLine(m6.ToString());

            // Collection testing
            pmcore.Collection cc = new pmcore.Collection(2);

            cc.set_VectorName(0, "test1");
            cc.set_VectorName(1, "test2");
            cc.set_VectorVisibility(1, false);

            cc.Add(0, 1); cc.Add(1, 11);
            cc.Add(0, 2); cc.Add(1, 22);
            cc.Add(0, 3); cc.Add(1, 33);
            cc.Add(0, 4); cc.Add(1, 44);

            //cc.Load_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            cc.Save_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(002)_s_pr1__.txt", null);
            Console.WriteLine("    done");

            Console.WriteLine(cc[0][0].ToString());
            Console.WriteLine(cc[0][1].ToString());



            Console.ReadKey();
        }
    }
}

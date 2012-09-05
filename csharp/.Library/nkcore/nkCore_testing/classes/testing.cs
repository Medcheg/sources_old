using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms.DataVisualization.Charting;


namespace nkCore_testing.classes
{
    public class testing
    {
        public nkcore.Types.Collection cc;
        public void testing_regression( System.Windows.Forms.TextBox textbox, Chart chart)
        {
            // Regression testing
            if ( textbox != null ) textbox.Text += "Regression testing";
            nkcore.Types.Collection base_collection = new nkcore.Types.Collection("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            
            //nkcore.Types.Collection base_collection = new nkcore.Types.Collection(2);
            //base_collection.Add(0,0);  base_collection.Add(1,0);
            //base_collection.Add(0,1);  base_collection.Add(1,0.5);
            //base_collection.Add(0,2);  base_collection.Add(1,1);

            nkcore.Types.Collection c1 = base_collection.get_SubCollection(new int[]{0});
            nkcore.Types.Collection c2 = base_collection.get_SubCollection(new int[]{1, 2, 3, 4});
            int []power_array = new int[]{0, 1, 2, 3, 4};

            double [][]res = nkcore.Math.Regression(c1, c2, power_array);
            for ( int i = 0 ; i < c2.VectorsCount; i++)
            {
                System.Console.WriteLine("  vector1  = ");
                if ( textbox != null ) textbox.Text += System.Environment.NewLine + "  vector" + i.ToString() + "  = ";

                for ( int k = 0; k < power_array.Length; k++ )
                {
                    System.Console.Write(res[i][k].ToString("f9") + "\t");
                    if ( textbox != null ) textbox.Text += res[i][k].ToString("f9") + "\t";
                }
            }

            System.Console.WriteLine("");
            if ( textbox != null ) textbox.Text += System.Environment.NewLine;
            if ( textbox != null ) textbox.Text += System.Environment.NewLine;

            List<double> correctionResult       = new List<double>(); 
            List<double> correctionResult_error = new List<double>(); 

            for ( int i = 0; i < c1[0].Count; i++)
            {
                double value = 0;
                for ( int k = 0;  k < c2.VectorsCount; k++)
                {
                    for ( int z = 0; z < power_array.Length; z++ )
                    {
                        value += res[k][z] * Math.Pow( c2[k][i] , power_array[z]); 
                    }
                }
                
                correctionResult.Add(value);
                correctionResult_error.Add((c1[0][i] - value)/0.035*3600.0);
            }

            chart.Series[0].Points.DataBindY(c1[0]);
            chart.Series[1].Points.DataBindY(correctionResult);
            chart.Series[2].Points.DataBindY(correctionResult_error);

        }

        public void testing_matix(System.Windows.Forms.TextBox textbox)
        {
            // Matrix testing
            if ( textbox != null ) textbox.Text += "Matrix testing" + System.Environment.NewLine;
            double []in_array = {1, 2, 1, 
                                 4, 1, 6, 
                                 1, 2, 3};
            nkcore.Types.Matrix m1 = new nkcore.Types.Matrix(3, 3, in_array);
            nkcore.Types.Matrix m2 = new nkcore.Types.Matrix(m1);
            nkcore.Types.Matrix m3 = m1+m2;
            nkcore.Types.Matrix m4 =  (m1+m2)*(m1+m2);
            nkcore.Types.Matrix m5 = ((m1+m2)*(m1+m2)).Inverse();
            nkcore.Types.Matrix m6 = m4*m5;

            //Console.WriteLine(m1.ToString());
            //Console.WriteLine(m2.ToString());
            Console.WriteLine(m3.ToString());
            Console.WriteLine(m4.ToString());
            Console.WriteLine(m5.ToString());
            Console.WriteLine(m6.ToString());
            Console.WriteLine("");

            if ( textbox != null ) {
                textbox.Text += m3.ToString() + System.Environment.NewLine;
                textbox.Text += m4.ToString() + System.Environment.NewLine;
                textbox.Text += m5.ToString() + System.Environment.NewLine;
                textbox.Text += m6.ToString() + System.Environment.NewLine;
                textbox.Text += System.Environment.NewLine;
            }
        }

        public void testing_collection(System.Windows.Forms.TextBox textbox)
        {
            // Collection testing
            if ( textbox != null ) textbox.Text += "Collection testing" + System.Environment.NewLine;

            cc = new nkcore.Types.Collection(2);

            cc.set_VectorName(0, "test1");
            cc.set_VectorName(1, "test2");
            cc.set_VectorVisibility(1, false);

            cc.Add(0, 1); cc.Add(1, 11);
            cc.Add(0, 2); cc.Add(1, 22);
            cc.Add(0, 3); cc.Add(1, 33);
            cc.Add(0, 4); cc.Add(1, 44);

            cc.Load_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            cc.Save_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(002)_s_pr1__.txt", null);
            Console.WriteLine("Collection - done");
            if ( textbox != null ) textbox.Text += "Collection - done" + System.Environment.NewLine;
        }

        public void testing_AllanVariance(System.Windows.Forms.TextBox textbox, ref bool isBreak)
        {
            // Regression testing
            if ( textbox != null ) textbox.Text += "Regression testing";
            nkcore.Types.Collection base_collection = new nkcore.Types.Collection("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);

            nkcore.Types.Collection dd = nkcore.Math.AllanVariance( base_collection, ref isBreak );
        }

    }
}


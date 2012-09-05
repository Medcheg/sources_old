using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace nkCore_testing
{
    public partial class Form1 : Form
    {
        bool isBreak;
        private int mouse_xPos;
        private int mouse_yPos;
        private PictureBox picture_box;

        public Form1()
        {
            InitializeComponent();

            picture_box = new PictureBox();
            picture_box.Parent = chart1;



            this.StartPosition = FormStartPosition.CenterScreen;

            chart1.ChartAreas.Clear();
            chart1.Series.Clear();
            
            chart1.ChartAreas.Add(new ChartArea("First"));
            chart1.ChartAreas.Add(new ChartArea("Second"));

            for ( int i = 0; i < 10; i++)
            {
                Series series = new Series();
                series.ChartArea = ( i / 5 == 0 ) ? "First" : "Second";
                series.ChartType = SeriesChartType.FastLine;

                chart1.Series.Add(series);
            }

            //////
            for ( int i = 0; i < chart1.ChartAreas.Count; i++ )
            {
                //chart1.ChartAreas[i].AlignmentOrientation = AreaAlignmentOrientations.None;
                //chart1.ChartAreas[i].Position = new ElementPosition(0, 100, 200, 100);
                //chart1.ChartAreas[i].AlignmentOrientation = AreaAlignmentOrientations.Vertical;
                //chart1.ChartAreas[i].AlignmentStyle = AreaAlignmentStyles.PlotPosition;
                chart1.ChartAreas[i].AlignWithChartArea = "First";

                chart1.ChartAreas[i].Visible = true;
                chart1.ChartAreas[i].BorderWidth = 2;
                chart1.ChartAreas[i].BorderDashStyle = ChartDashStyle.Solid;

                chart1.ChartAreas[i].AxisX.IsStartedFromZero = false;
                chart1.ChartAreas[i].AxisY.IsStartedFromZero = false;

                chart1.ChartAreas[i].AxisX.IsLogarithmic     = false;
                chart1.ChartAreas[i].AxisY.IsLogarithmic     = false;

                //chart1.ChartAreas[i].AxisX.ArrowStyle        = AxisArrowStyle.Triangle;
                //chart1.ChartAreas[i].AxisX.LineColor         = Color.Black;
                chart1.ChartAreas[i].AxisX.LabelStyle.Enabled = true;

                //chart1.ChartAreas[i].AxisY.ArrowStyle        = AxisArrowStyle.Triangle;
                //chart1.ChartAreas[i].AxisY.LineColor         = Color.Black;
            
                chart1.ChartAreas[i].AxisY.MajorGrid.Enabled = true;
                chart1.ChartAreas[i].AxisX.MajorGrid.Enabled = true;
                
                chart1.ChartAreas[i].AxisY.MajorGrid.LineWidth = 1;

                chart1.ChartAreas[i].AxisX.MinorGrid.Enabled = false;
                chart1.ChartAreas[i].AxisX.MinorGrid.LineColor = Color.Silver;
                chart1.ChartAreas[i].AxisX.MinorGrid.LineDashStyle = ChartDashStyle.Dash;

                chart1.ChartAreas[i].AxisY.MinorGrid.Enabled = false;
                chart1.ChartAreas[i].AxisY.MinorGrid.LineColor = Color.Silver;
                chart1.ChartAreas[i].AxisY.MinorGrid.LineDashStyle = ChartDashStyle.Dash;

                chart1.Dock   = DockStyle.Fill;

                chart1.Legends.Clear();
                chart1.Titles.Clear();
            }
        }

        private void Init_Chart( Chart chart )
        {
            for ( int i = 0; i < chart.ChartAreas.Count; i++ )
            {
                chart.ChartAreas[i].AxisX.IsLogarithmic = false;
                chart.ChartAreas[i].AxisY.IsLogarithmic = false;

                //chart.ChartAreas[i].AxisX.IsMarginVisible = false;

                chart.ChartAreas[i].AxisX.Minimum = double.NaN;
                chart.ChartAreas[i].AxisX.Maximum = double.NaN;
                chart.ChartAreas[i].AxisY.Minimum = double.NaN;
                chart.ChartAreas[i].AxisY.Maximum = double.NaN;

                chart.ChartAreas[i].Visible = false;
            }
            for ( int i = 0; i < chart.Series.Count; i++)
            {
                chart.Series[i].BorderWidth = 2;
                chart.Series[i].Points.Clear();
            }

            chart.ChartAreas[0].Visible = true;
        }

        private void button_Collection_Click(object sender, EventArgs e)
        {
            Init_Chart(chart1);
            textBox1.Clear();
            tabControl1.SelectedIndex = 2;

            textBox1.Text  = "Collection testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;

            mcore.Types.Collection collection = new mcore.Types.Collection(2);

            // local test
            collection.set_VectorName(0, "test1");
            collection.set_VectorName(1, "test2");
            collection.set_VectorVisibility(1, false);

            collection.Add(0, 1); collection.Add(1, 11);
            collection.Add(0, 2); collection.Add(1, 22);
            collection.Add(0, 3); collection.Add(1, 33);
            collection.Add(0, 4); collection.Add(1, 44);

            // file load
            collection.Load_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            collection.Save_TextFile("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(002)_s_pr1__.txt", null);

            chart1.Series[0].Points.DataBindY(collection[0]);
            
            textBox1.Text += "Collection - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
        }
        private void button_Regression_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            Init_Chart(chart1);

            tabControl1.SelectedIndex = 1;

            textBox1.Text  = "Regression testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;
            System.Windows.Forms.Application.DoEvents();
            //

            mcore.Types.Collection collection = new mcore.Types.Collection("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            
            mcore.Types.Collection c1 = collection.get_SubCollection(new int[]{0});
            mcore.Types.Collection c2 = collection.get_SubCollection(new int[]{1, 2, 3, 4});
            int []power_array = new int[]{0, 1, 2, 3, 4};

            double [][]res = mcore.Math.Regression(c1, c2, power_array);

            // Вывод результата (коэффициенты)
            for ( int i = 0 ; i < c2.VectorsCount; i++)
            {
                textBox1.Text += System.Environment.NewLine + "  vector" + i.ToString() + "  = ";
                for ( int k = 0; k < power_array.Length; k++ )
                    textBox1.Text += res[i][k].ToString("f9") + "\t";
            }

            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            // Графическое представление коррекции
            List<double> correctionResult       = new List<double>(); 
            List<double> correctionResult_error = new List<double>(); 

            for ( int i = 0; i < c1[0].Count; i++)
            {
                double value = 0;
                for ( int k = 0;  k < c2.VectorsCount; k++)
                    for ( int z = 0; z < power_array.Length; z++ )
                    {
                        value += res[k][z] * Math.Pow( c2[k][i] , power_array[z]); 
                    }
                
                correctionResult.Add(value);
                correctionResult_error.Add((c1[0][i] - value)/0.035*3600.0);
            }

            chart1.Series[0].Points.DataBindY(c1[0]);
            chart1.Series[1].Points.DataBindY(correctionResult);
            chart1.Series[5].Points.DataBindY(correctionResult_error);
            chart1.ChartAreas[1].Visible = true;
                        
            //
            textBox1.Text += "Regression - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
        }
        private void button_Matrix_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            Init_Chart(chart1);
            tabControl1.SelectedIndex = 1;

            textBox1.Text  = "Matix testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;

            mcore.Types.Collection collection = new mcore.Types.Collection(2);

            // local test
            double []in_array = {1, 2, 1, 
                                 4, 1, 6, 
                                 1, 2, 3};

            mcore.Types.Matrix m1 = new mcore.Types.Matrix(3, 3, in_array);
            mcore.Types.Matrix m2 = new mcore.Types.Matrix(m1);
            mcore.Types.Matrix m3 =   m1+m2;
            mcore.Types.Matrix m4 =  (m1+m2)*(m1+m2);
            mcore.Types.Matrix m5 = ((m1+m2)*(m1+m2)).Inverse();
            mcore.Types.Matrix m6 = m4*m5;

            textBox1.Text += "m3 = m1 + m2" + System.Environment.NewLine;
            textBox1.Text += m3.ToString() + System.Environment.NewLine;

            textBox1.Text += "m4 = (m1+m2)*(m1+m2)" + System.Environment.NewLine;
            textBox1.Text += m4.ToString() + System.Environment.NewLine;

            textBox1.Text += "m5 = ((m1+m2)*(m1+m2)).Inverse()" + System.Environment.NewLine;
            textBox1.Text += m5.ToString() + System.Environment.NewLine;

            textBox1.Text += "m6 = m4 * m5" + System.Environment.NewLine;
            textBox1.Text += m6.ToString() + System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            // 
            textBox1.Text += "Matrix testing - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
        }
        
        private void button_AllanVariance_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            Init_Chart(chart1);
            tabControl1.SelectedIndex = 2;
            progressBar1.Value = 0;

            textBox1.Text  = "Allan Variance testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;
            System.Windows.Forms.Application.DoEvents();
            //

            isBreak = false;
            mcore.Types.Collection collection = new mcore.Types.Collection("E:\\.PersonalProjects\\CSharp\\.Library\\.Data\\01-0078_(810).exp(001)_s_pr1.txt", null);
            mcore.Types.Collection dd = mcore.Math.AllanVariance( 0.1, collection, ref isBreak, progressBar1 );
                     

            //double[] x = new double[]{0.1, 1, 2, 3, 4, 5, 7, 8, 9, 10};
            //double[] y = new double[]{0.1, 0.2, 0.3, 0.04, 5, 0.06, .07, 0.8, 0.9, 0.10};

            //chart1.Series[0].Points.DataBindXY(x, y);
            //
            chart1.Series[0].Points.DataBindXY(dd[0], dd[1]);
            //chart1.Series[0].Points.DataBindY(dd[0]);

            chart1.ChartAreas[0].AxisX.IsLogarithmic = true;
            chart1.ChartAreas[0].AxisY.IsLogarithmic = true;

            textBox1.Text += "Allan Variance calculation - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
        }
        private void button_BreakCalculation_Click(object sender, EventArgs e)
        {
            isBreak = true;
        }

        private void button_Filtration_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            Init_Chart(chart1);
            tabControl1.SelectedIndex = 2;
            progressBar1.Value = 0;

            textBox1.Text  = "Filtration testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;
            System.Windows.Forms.Application.DoEvents();
            //

            int filtertype = 1;
            mcore.Digital filter;
            switch ( filtertype )
            {
                case 1  : filter = new mcore.Digital.filter_loPass  (0.001, 100, 1); break;
                case 2  : filter = new mcore.Digital.filter_hiPass  (0.001, 100, 1); break;
                case 3  : filter = new mcore.Digital.filter_bandStop(0.001, 50, 50); break;
                case 4  : filter = new mcore.Digital.filter_bandPass(0.001, 50, 5 ); break;
                case 5  : filter = new mcore.Digital.phase_Corrector(0.001, 100   ); break;
                default : filter = null; break;
            }
            
            mcore.Types.Collection c = mcore.Math.Frequency_responce(1, 1000, 0.001, filter.coefs);

                for ( int i = 0 ; i < filter.coefs[0].Count; i++ )
                    textBox1.Text += "a" + i.ToString() + " = " + filter.coefs[0][i] + System.Environment.NewLine;
                
                textBox1.Text += System.Environment.NewLine;
                for ( int i = 0 ; i < filter.coefs[1].Count; i++ )
                    textBox1.Text += "b" + i.ToString() + " = " + filter.coefs[1][i] + System.Environment.NewLine;


                chart1.Series[0].Points.DataBindXY(c[0], c[1]);
                chart1.Series[1].Points.DataBindXY(c[0], c[2]);
                
                chart1.ChartAreas[0].AxisX.IsLogarithmic = true;
                chart1.ChartAreas[0].AxisX.Minimum = c.Vectors[0].Minimum;
                chart1.ChartAreas[0].AxisX.Maximum = c.Vectors[0].Maximum;

            //
            textBox1.Text += "Filtration testing - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
            //isBreak = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            Init_Chart(chart1);
            tabControl1.SelectedIndex = 2;
            progressBar1.Value = 0;

            textBox1.Text  = "FFT testing";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            int t1 = System.Environment.TickCount;
            System.Windows.Forms.Application.DoEvents();

            //
            mcore.Types.Collection fft_col = new mcore.Types.Collection(2);
            double power = 0;
            double t0 = 0.001;
            double sinus_freq = 100;

            for ( int i = 0; i < 10000; i++)
            {
                fft_col.Add(0, System.Math.Sin(2.0 * Math.PI * sinus_freq * i * t0 ));
                fft_col.Add(1, 0);
            }
            
            mcore.Math.FFT(fft_col, ref power);

            mcore.Types.Collection fft_draw = new mcore.Types.Collection(2);
            int DataCount = (int)System.Math.Pow(2.0, power);
            double WorkFreq = 1.0 / t0;
            double minFreq = 1;
            double maxFreq = WorkFreq / 2;

            for ( int i = 0; i < DataCount / 2; i++)
            {
                double xVal = i / (double)DataCount * WorkFreq;
                if ( xVal >= minFreq && xVal < maxFreq )
                {
                    double yVal = System.Math.Sqrt(fft_col[0][i]*fft_col[0][i] + fft_col[1][i]*fft_col[1][i])*2.0 / (double)DataCount;

                    fft_draw.Add(0, xVal);
                    fft_draw.Add(1, yVal);
                }
            }

            chart1.Series[0].Points.DataBindXY(fft_draw[0], fft_draw[1]);
            chart1.Series[0].BorderWidth = 2;
            chart1.ChartAreas[0].AxisX.IsLogarithmic = true;
            chart1.ChartAreas[0].AxisY.IsLogarithmic = true;

            //
            textBox1.Text += "FFT testing - done";
            textBox1.Text += System.Environment.NewLine;
            textBox1.Text += System.Environment.NewLine;

            textBox1.Text += "Time elapsed = " + ((System.Environment.TickCount - t1)*0.001).ToString() + " sec";
            //isBreak = true;
        }

        private void chart1_MouseClick(object sender, MouseEventArgs e)
        {

        }

        private void chart1_MouseLeave(object sender, EventArgs e)
        {

        }

        private void chart1_MouseEnter(object sender, EventArgs e)
        {

        }

        private void chart1_MouseMove(object sender, MouseEventArgs e)
        {
            this.Text  = e.X.ToString() + "   ";  
            this.Text += e.Y.ToString() + "   ";  

            mouse_xPos = e.X;
            mouse_yPos = e.Y;

            Graphics gr = chart1.CreateGraphics();
            gr.DrawLine(new Pen(Color.Red), -20 + mouse_xPos, -20 + mouse_yPos,  20 + mouse_xPos, 20 + mouse_yPos);
            gr.DrawLine(new Pen(Color.Red),  20 + mouse_xPos, -20 + mouse_yPos, -20 + mouse_xPos, 20 + mouse_yPos);

            chart1.Invalidate();
        }

        private void chart1_Paint(object sender, PaintEventArgs e)
        {
              //e.Graphics.
//            e.Graphics.DrawLine(new Pen(Color.Red), -20 + mouse_xPos, -20 + mouse_yPos,  20 + mouse_xPos, 20 + mouse_yPos);
//            e.Graphics.DrawLine(new Pen(Color.Red),  20 + mouse_xPos, -20 + mouse_yPos, -20 + mouse_xPos, 20 + mouse_yPos);
        }

        private void chart1_PostPaint(object sender, ChartPaintEventArgs e)
        {
            e.ChartGraphics.Graphics.DrawLine(new Pen(Color.Red), -20 + mouse_xPos, -20 + mouse_yPos,  20 + mouse_xPos, 20 + mouse_yPos);
            e.ChartGraphics.Graphics.DrawLine(new Pen(Color.Red),  20 + mouse_xPos, -20 + mouse_yPos, -20 + mouse_xPos, 20 + mouse_yPos);
        }

        private void chart1_PrePaint(object sender, ChartPaintEventArgs e)
        {
            //e.ChartGraphics.Graphics.DrawLine(new Pen(Color.Red), -20 + mouse_xPos, -20 + mouse_yPos,  20 + mouse_xPos, 20 + mouse_yPos);
            //e.ChartGraphics.Graphics.DrawLine(new Pen(Color.Red),  20 + mouse_xPos, -20 + mouse_yPos, -20 + mouse_xPos, 20 + mouse_yPos);
        }



    }
}

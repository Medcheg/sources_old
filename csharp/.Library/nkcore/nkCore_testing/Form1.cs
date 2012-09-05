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
        classes.testing testing = new classes.testing();
        bool isBreak;

        public Form1()
        {
            InitializeComponent();


            int t1 = System.Environment.TickCount;
            
            this.StartPosition = FormStartPosition.CenterScreen;
            this.Text = (System.Environment.TickCount - t1).ToString();

            chart1.ChartAreas.Clear();
            chart1.Series.Clear();
            
            chart1.ChartAreas.Add(new ChartArea("First"));
            chart1.ChartAreas.Add(new ChartArea("Second"));

            Series series1 = new Series();
            Series series2 = new Series();
            Series series3 = new Series();
            
            series1.Color = Color.Blue;
            series1.ChartArea = "First";
            series1.ChartType = SeriesChartType.FastLine;

            series2.Color = Color.Yellow;
            series2.ChartArea = "First";
            series2.ChartType = SeriesChartType.FastLine;

            series3.Color = Color.Blue;
            series3.ChartArea = "Second";
            series3.ChartType = SeriesChartType.FastLine;

            chart1.Series.Add(series1);
            chart1.Series.Add(series2);
            chart1.Series.Add(series3);

            
            //////
            for ( int i = 0; i < chart1.ChartAreas.Count; i++ )
            {
                chart1.ChartAreas[i].Visible = true;
                chart1.ChartAreas[i].BorderWidth = 2;
                chart1.ChartAreas[i].BorderDashStyle = ChartDashStyle.Solid;

                //chart1.ChartAreas[i].AxisX.ArrowStyle        = AxisArrowStyle.Triangle;
                chart1.ChartAreas[i].AxisX.IsLogarithmic     = false;
                chart1.ChartAreas[i].AxisX.IsStartedFromZero = false;
                chart1.ChartAreas[i].AxisX.LineColor         = Color.Red;
                chart1.ChartAreas[i].AxisX.LabelStyle.Enabled = false;

                //chart1.ChartAreas[i].AxisY.ArrowStyle        = AxisArrowStyle.Triangle;
                chart1.ChartAreas[i].AxisY.IsLogarithmic     = false;
                chart1.ChartAreas[i].AxisY.IsStartedFromZero = false;
                chart1.ChartAreas[i].AxisY.LineColor         = Color.Red;
            
                chart1.ChartAreas[i].AxisY.MajorGrid.Enabled = false;
                chart1.ChartAreas[i].AxisX.MajorGrid.Enabled = false;
                chart1.ChartAreas[i].AxisY.MajorGrid.LineWidth = 1;

                chart1.ChartAreas[i].AxisX.MinorGrid.Enabled = true;
                chart1.ChartAreas[i].AxisX.MinorGrid.LineColor = Color.Silver;
                chart1.ChartAreas[i].AxisX.MinorGrid.LineDashStyle = ChartDashStyle.Dash;

                chart1.ChartAreas[i].AxisY.MinorGrid.Enabled = true;
                chart1.ChartAreas[i].AxisY.MinorGrid.LineColor = Color.Silver;
                chart1.ChartAreas[i].AxisY.MinorGrid.LineDashStyle = ChartDashStyle.Dash;

                //chart1.ChartAreas[i].Position.Width  = 80;
                //chart1.ChartAreas[i].Position.Height = 90;
                //chart1.ChartAreas[i].Position.X = 30;

                chart1.Dock   = DockStyle.Right;
                chart1.Anchor = AnchorStyles.Bottom|AnchorStyles.Left|AnchorStyles.Right|AnchorStyles.Top;

                //chart1.Series[0].IsVisibleInLegend = false;
                chart1.Legends.Clear();
                chart1.Titles.Clear();
            }

            /////////////////////////
                //testing.testing_regression(textBox1, chart1);
                testing.testing_matix     (textBox1);

                nkcore.Digital.filter_loPass lo = new nkcore.Digital.filter_loPass(0.001, 100, 1);
                nkcore.Types.Collection c = nkcore.Math.Frequency_responce(0.1, 1000, 0.001, lo.coefs);
                //testing.testing_collection(textBox1);
            /////////////////////////

            
            series1.Points.DataBindXY(c[0], c[1]);
            series3.Points.DataBindXY(c[0], c[2]);
            //series2.Points.DataBindY(testing.cc[0]);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            isBreak = false;
            testing.testing_AllanVariance(textBox1, ref isBreak);
                
            MessageBox.Show("done");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            isBreak = true;
        }
    }
}

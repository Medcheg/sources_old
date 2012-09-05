using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace ccg_DataTools
{
    public partial class Form1 : Form
    {
        private ccgcore.Collection Collection_base;
        private ccgcore.Collection Collection_correct;

        public Form1()
        {
            InitializeComponent();

            StartPosition = FormStartPosition.CenterScreen;

            Collection_base = new ccgcore.Collection();

            chart1.Series[0].Points.AddXY(1, 1);
            chart1.Series[1].Points.AddXY(1, 1);
            //chart1.ChartAreas[0].AxisX.Minimum = 0;
            //chart1.ChartAreas[0].AxisY.Minimum = 0;
            //chart1.ChartAreas[1].AxisX.Minimum = 0;
            //chart1.ChartAreas[1].AxisY.Minimum = 0;

            //chart1.ChartAreas[0].AxisX.Maximum = 4;
            //chart1.ChartAreas[0].AxisY.Maximum = 4;
            //chart1.ChartAreas[1].AxisX.Maximum = 4;
            //chart1.ChartAreas[1].AxisY.Maximum = 4;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button_LoadDataFile_Click(object sender, EventArgs e)
        {
            openFileDialog1.DefaultExt = "txt";
            DialogResult res = openFileDialog1.ShowDialog();

            if ( res == System.Windows.Forms.DialogResult.OK )
            {
                textBox2.Text = "Open\r\n";
                Application.DoEvents();

                Collection_base.File.Load_TextFile(openFileDialog1.FileName, progressBar1);

                textBox2.Text += "Loaded\r\n";

                Application.DoEvents();
                Collection_correct = new ccgcore.Collection(Collection_base);

                textBox2.Text += "Copied\r\n";
                Application.DoEvents();

//                chart1.ChartAreas["Raw Values"].

                chart1.Series[0].Points.Clear();
                chart1.Series[1].Points.Clear();
                chart1.Series[0].Points.DataBindY(Collection_base[0]);
                chart1.Series[1].Points.DataBindY(Collection_correct[0]);

                textBox2.Text += "Drawed\r\n";
                Application.DoEvents();


                chart1.ChartAreas[0].CursorX.AutoScroll = true;
                chart1.ChartAreas[0].CursorY.AutoScroll = true;
                
                chart1.ChartAreas[0].AxisY.ScaleView.Zoomable = true;
                chart1.ChartAreas[0].AxisX.ScaleView.Zoomable = true;

                chart1.ChartAreas[0].AxisY.Minimum = 0;

                chart1.ChartAreas[0].CursorX.Interval = 1e-6;
                chart1.ChartAreas[0].CursorY.Interval = 1e-6;
            }
        }

        private void button_SaveDataFile_Click(object sender, EventArgs e)
        {
            //
        }

        private void button_AcceptPolinom_Click(object sender, EventArgs e)
        {
            //
        }

        private void button1_Click(object sender, EventArgs e)
        {
            while ( chart1.ChartAreas[0].AxisX.ScaleView.IsZoomed )
                chart1.ChartAreas[0].AxisX.ScaleView.ZoomReset();
            
            while ( chart1.ChartAreas[0].AxisY.ScaleView.IsZoomed )
                chart1.ChartAreas[0].AxisY.ScaleView.ZoomReset();

        }

        private void chart1_Click(object sender, EventArgs e)
        {

        }

        private void fileToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void выходToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

//*IDN? /r/n
//READ?

//TRAC:CLE
//INIT:CONT OFF
//TRIG:SOUR IMM
//TRIG:COUN 1
//SAMP:COUN 1
//SAMP:SCAN(@101:110)
//ROUT:SCAN:TSO IMM
//ROUT:SCAN:LSES INT
//READ?
//ROUT::SCAN:LSEL NONE

namespace WindowsFormsApplication1
{
    public partial class form_Main : Form
    {
        SerialPort sp = new SerialPort("COM2");
        public Timer timer = new Timer();
        public static string indata;

        public form_Main()
        {
            InitializeComponent();

            StartPosition = FormStartPosition.CenterScreen;
            timer.Interval = 100;
            timer.Tick += new EventHandler(timer_Tick);

            sp.BaudRate = 9600;
            sp.Parity = Parity.None;
            sp.StopBits = StopBits.One;
            sp.DataBits = 8;
            sp.Handshake = Handshake.XOnXOff;
            sp.DataReceived += new SerialDataReceivedEventHandler(DataReceivedHandler);
        }

        private static void DataReceivedHandler( object sender, SerialDataReceivedEventArgs e)
        {
            SerialPort sp = (SerialPort)sender;
            indata += sp.ReadExisting();

            int pos = 0;
            foreach (char ch in indata)
            {
                pos++;
                if (ch == '#')
                {
                    Console.Write(indata.Substring(0, pos));
                    indata = indata.Remove(0, pos);
                }
            }
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            if (sp.IsOpen == true)
            {
                sp.Write("READ?\r");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            sp.Open();
            timer.Enabled = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            sp.Close();
        }
    }
}

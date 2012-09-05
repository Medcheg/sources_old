namespace nkCore_testing
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        	System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
        	System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
        	System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
        	System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
        	System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
        	this.tabControl1 = new System.Windows.Forms.TabControl();
        	this.tabPage1 = new System.Windows.Forms.TabPage();
        	this.button1 = new System.Windows.Forms.Button();
        	this.progressBar1 = new System.Windows.Forms.ProgressBar();
        	this.button_BreakCalculation = new System.Windows.Forms.Button();
        	this.button_Filtration = new System.Windows.Forms.Button();
        	this.button_AllanVariance = new System.Windows.Forms.Button();
        	this.button_Matrix = new System.Windows.Forms.Button();
        	this.button_Regression = new System.Windows.Forms.Button();
        	this.button_Collection = new System.Windows.Forms.Button();
        	this.tabPage2 = new System.Windows.Forms.TabPage();
        	this.textBox1 = new System.Windows.Forms.TextBox();
        	this.tabPage3 = new System.Windows.Forms.TabPage();
        	this.chart1 = new System.Windows.Forms.DataVisualization.Charting.Chart();
        	this.tabControl1.SuspendLayout();
        	this.tabPage1.SuspendLayout();
        	this.tabPage2.SuspendLayout();
        	this.tabPage3.SuspendLayout();
        	((System.ComponentModel.ISupportInitialize)(this.chart1)).BeginInit();
        	this.SuspendLayout();
        	// 
        	// tabControl1
        	// 
        	this.tabControl1.Controls.Add(this.tabPage1);
        	this.tabControl1.Controls.Add(this.tabPage2);
        	this.tabControl1.Controls.Add(this.tabPage3);
        	this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
        	this.tabControl1.Location = new System.Drawing.Point(0, 0);
        	this.tabControl1.Name = "tabControl1";
        	this.tabControl1.SelectedIndex = 0;
        	this.tabControl1.Size = new System.Drawing.Size(764, 342);
        	this.tabControl1.TabIndex = 4;
        	// 
        	// tabPage1
        	// 
        	this.tabPage1.Controls.Add(this.button1);
        	this.tabPage1.Controls.Add(this.progressBar1);
        	this.tabPage1.Controls.Add(this.button_BreakCalculation);
        	this.tabPage1.Controls.Add(this.button_Filtration);
        	this.tabPage1.Controls.Add(this.button_AllanVariance);
        	this.tabPage1.Controls.Add(this.button_Matrix);
        	this.tabPage1.Controls.Add(this.button_Regression);
        	this.tabPage1.Controls.Add(this.button_Collection);
        	this.tabPage1.Location = new System.Drawing.Point(4, 22);
        	this.tabPage1.Name = "tabPage1";
        	this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
        	this.tabPage1.Size = new System.Drawing.Size(756, 316);
        	this.tabPage1.TabIndex = 0;
        	this.tabPage1.Text = "tabPage1";
        	this.tabPage1.UseVisualStyleBackColor = true;
        	// 
        	// button1
        	// 
        	this.button1.Location = new System.Drawing.Point(8, 122);
        	this.button1.Name = "button1";
        	this.button1.Size = new System.Drawing.Size(89, 23);
        	this.button1.TabIndex = 10;
        	this.button1.Text = "FFT";
        	this.button1.UseVisualStyleBackColor = true;
        	this.button1.Click += new System.EventHandler(this.button1_Click);
        	// 
        	// progressBar1
        	// 
        	this.progressBar1.Dock = System.Windows.Forms.DockStyle.Bottom;
        	this.progressBar1.Location = new System.Drawing.Point(3, 290);
        	this.progressBar1.Name = "progressBar1";
        	this.progressBar1.Size = new System.Drawing.Size(750, 23);
        	this.progressBar1.TabIndex = 9;
        	// 
        	// button_BreakCalculation
        	// 
        	this.button_BreakCalculation.Location = new System.Drawing.Point(631, 3);
        	this.button_BreakCalculation.Name = "button_BreakCalculation";
        	this.button_BreakCalculation.Size = new System.Drawing.Size(117, 23);
        	this.button_BreakCalculation.TabIndex = 8;
        	this.button_BreakCalculation.Text = "Break Calculation";
        	this.button_BreakCalculation.UseVisualStyleBackColor = true;
        	this.button_BreakCalculation.Click += new System.EventHandler(this.button_BreakCalculation_Click);
        	// 
        	// button_Filtration
        	// 
        	this.button_Filtration.Location = new System.Drawing.Point(123, 6);
        	this.button_Filtration.Name = "button_Filtration";
        	this.button_Filtration.Size = new System.Drawing.Size(89, 23);
        	this.button_Filtration.TabIndex = 7;
        	this.button_Filtration.Text = "Digital";
        	this.button_Filtration.UseVisualStyleBackColor = true;
        	this.button_Filtration.Click += new System.EventHandler(this.button_Filtration_Click);
        	// 
        	// button_AllanVariance
        	// 
        	this.button_AllanVariance.Location = new System.Drawing.Point(8, 93);
        	this.button_AllanVariance.Name = "button_AllanVariance";
        	this.button_AllanVariance.Size = new System.Drawing.Size(89, 23);
        	this.button_AllanVariance.TabIndex = 6;
        	this.button_AllanVariance.Text = "Allan variance";
        	this.button_AllanVariance.UseVisualStyleBackColor = true;
        	this.button_AllanVariance.Click += new System.EventHandler(this.button_AllanVariance_Click);
        	// 
        	// button_Matrix
        	// 
        	this.button_Matrix.Location = new System.Drawing.Point(8, 64);
        	this.button_Matrix.Name = "button_Matrix";
        	this.button_Matrix.Size = new System.Drawing.Size(89, 23);
        	this.button_Matrix.TabIndex = 5;
        	this.button_Matrix.Text = "Matrix";
        	this.button_Matrix.UseVisualStyleBackColor = true;
        	this.button_Matrix.Click += new System.EventHandler(this.button_Matrix_Click);
        	// 
        	// button_Regression
        	// 
        	this.button_Regression.Location = new System.Drawing.Point(8, 35);
        	this.button_Regression.Name = "button_Regression";
        	this.button_Regression.Size = new System.Drawing.Size(89, 23);
        	this.button_Regression.TabIndex = 4;
        	this.button_Regression.Text = "Regression";
        	this.button_Regression.UseVisualStyleBackColor = true;
        	this.button_Regression.Click += new System.EventHandler(this.button_Regression_Click);
        	// 
        	// button_Collection
        	// 
        	this.button_Collection.Location = new System.Drawing.Point(8, 6);
        	this.button_Collection.Name = "button_Collection";
        	this.button_Collection.Size = new System.Drawing.Size(89, 23);
        	this.button_Collection.TabIndex = 2;
        	this.button_Collection.Text = "Collection";
        	this.button_Collection.UseVisualStyleBackColor = true;
        	this.button_Collection.Click += new System.EventHandler(this.button_Collection_Click);
        	// 
        	// tabPage2
        	// 
        	this.tabPage2.Controls.Add(this.textBox1);
        	this.tabPage2.Location = new System.Drawing.Point(4, 22);
        	this.tabPage2.Name = "tabPage2";
        	this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
        	this.tabPage2.Size = new System.Drawing.Size(756, 316);
        	this.tabPage2.TabIndex = 1;
        	this.tabPage2.Text = "tabPage2";
        	this.tabPage2.UseVisualStyleBackColor = true;
        	// 
        	// textBox1
        	// 
        	this.textBox1.Dock = System.Windows.Forms.DockStyle.Fill;
        	this.textBox1.Location = new System.Drawing.Point(3, 3);
        	this.textBox1.Multiline = true;
        	this.textBox1.Name = "textBox1";
        	this.textBox1.Size = new System.Drawing.Size(750, 310);
        	this.textBox1.TabIndex = 2;
        	// 
        	// tabPage3
        	// 
        	this.tabPage3.Controls.Add(this.chart1);
        	this.tabPage3.Location = new System.Drawing.Point(4, 22);
        	this.tabPage3.Name = "tabPage3";
        	this.tabPage3.Padding = new System.Windows.Forms.Padding(3);
        	this.tabPage3.Size = new System.Drawing.Size(756, 316);
        	this.tabPage3.TabIndex = 2;
        	this.tabPage3.Text = "tabPage3";
        	this.tabPage3.UseVisualStyleBackColor = true;
        	// 
        	// chart1
        	// 
        	chartArea1.Name = "ChartArea1";
        	chartArea2.Name = "ChartArea2";
        	this.chart1.ChartAreas.Add(chartArea1);
        	this.chart1.ChartAreas.Add(chartArea2);
        	this.chart1.Dock = System.Windows.Forms.DockStyle.Fill;
        	legend1.Enabled = false;
        	legend1.LegendStyle = System.Windows.Forms.DataVisualization.Charting.LegendStyle.Column;
        	legend1.Name = "Legend1";
        	this.chart1.Legends.Add(legend1);
        	this.chart1.Location = new System.Drawing.Point(3, 3);
        	this.chart1.Name = "chart1";
        	series1.ChartArea = "ChartArea1";
        	series1.Legend = "Legend1";
        	series1.Name = "Series1";
        	series2.ChartArea = "ChartArea2";
        	series2.Legend = "Legend1";
        	series2.Name = "Series2";
        	this.chart1.Series.Add(series1);
        	this.chart1.Series.Add(series2);
        	this.chart1.Size = new System.Drawing.Size(750, 310);
        	this.chart1.TabIndex = 3;
        	this.chart1.Text = "chart1";
        	this.chart1.PostPaint += new System.EventHandler<System.Windows.Forms.DataVisualization.Charting.ChartPaintEventArgs>(this.chart1_PostPaint);
        	this.chart1.PrePaint += new System.EventHandler<System.Windows.Forms.DataVisualization.Charting.ChartPaintEventArgs>(this.chart1_PrePaint);
        	this.chart1.Click += new System.EventHandler(this.Chart1Click);
        	this.chart1.Paint += new System.Windows.Forms.PaintEventHandler(this.chart1_Paint);
        	this.chart1.MouseClick += new System.Windows.Forms.MouseEventHandler(this.chart1_MouseClick);
        	this.chart1.MouseEnter += new System.EventHandler(this.chart1_MouseEnter);
        	this.chart1.MouseLeave += new System.EventHandler(this.chart1_MouseLeave);
        	this.chart1.MouseMove += new System.Windows.Forms.MouseEventHandler(this.chart1_MouseMove);
        	// 
        	// Form1
        	// 
        	this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
        	this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
        	this.ClientSize = new System.Drawing.Size(764, 342);
        	this.Controls.Add(this.tabControl1);
        	this.Name = "Form1";
        	this.Text = "Form1";
        	this.tabControl1.ResumeLayout(false);
        	this.tabPage1.ResumeLayout(false);
        	this.tabPage2.ResumeLayout(false);
        	this.tabPage2.PerformLayout();
        	this.tabPage3.ResumeLayout(false);
        	((System.ComponentModel.ISupportInitialize)(this.chart1)).EndInit();
        	this.ResumeLayout(false);
        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.Button button_Collection;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.DataVisualization.Charting.Chart chart1;
        private System.Windows.Forms.Button button_Regression;
        private System.Windows.Forms.Button button_Matrix;
        private System.Windows.Forms.Button button_AllanVariance;
        private System.Windows.Forms.Button button_Filtration;
        private System.Windows.Forms.Button button_BreakCalculation;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Button button1;


        
        void Chart1Click(object sender, System.EventArgs e)
        {
        	
        }
    }
}


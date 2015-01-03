using System;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using System.Data;

namespace Connect4
{
	/// <summary>
	/// Bishoy Mamdouh
	/// 14 May 2004
	/// BishoyMamdouh@hotmail.com
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		public int cx=15;
		public int cy=70;
		public int Level=3;
		public Connect4Board b=new Connect4Board();
		private System.Windows.Forms.MenuItem menuItem1;
		private System.Windows.Forms.MenuItem menuItem2;
		private System.Windows.Forms.MenuItem menuItem3;
		private System.Windows.Forms.MenuItem menuItem4;
		private System.Windows.Forms.MenuItem menuItem5;
		private System.Windows.Forms.MenuItem menuItem6;
		private System.Windows.Forms.MenuItem menuItem7;
		private System.Windows.Forms.MainMenu mainMenu1;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// 
			//
		}
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			base.Dispose( disposing );
		}
		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.mainMenu1 = new System.Windows.Forms.MainMenu();
			this.menuItem1 = new System.Windows.Forms.MenuItem();
			this.menuItem6 = new System.Windows.Forms.MenuItem();
			this.menuItem5 = new System.Windows.Forms.MenuItem();
			this.menuItem2 = new System.Windows.Forms.MenuItem();
			this.menuItem3 = new System.Windows.Forms.MenuItem();
			this.menuItem4 = new System.Windows.Forms.MenuItem();
			this.menuItem7 = new System.Windows.Forms.MenuItem();
			// 
			// mainMenu1
			// 
			this.mainMenu1.MenuItems.Add(this.menuItem1);
			this.mainMenu1.MenuItems.Add(this.menuItem2);
			// 
			// menuItem1
			// 
			this.menuItem1.MenuItems.Add(this.menuItem6);
			this.menuItem1.MenuItems.Add(this.menuItem5);
			this.menuItem1.Text = "New";
			// 
			// menuItem6
			// 
			this.menuItem6.Text = "Player First";
			this.menuItem6.Click += new System.EventHandler(this.menuItem6_Click);
			// 
			// menuItem5
			// 
			this.menuItem5.Text = "CPU First";
			this.menuItem5.Click += new System.EventHandler(this.menuItem5_Click);
			// 
			// menuItem2
			// 
			this.menuItem2.MenuItems.Add(this.menuItem3);
			this.menuItem2.MenuItems.Add(this.menuItem7);
			this.menuItem2.MenuItems.Add(this.menuItem4);
			this.menuItem2.Text = "Level";
			// 
			// menuItem3
			// 
			this.menuItem3.Checked = true;
			this.menuItem3.Text = "Easy";
			this.menuItem3.Click += new System.EventHandler(this.menuItem3_Click);
			// 
			// menuItem4
			// 
			this.menuItem4.Text = "Hard";
			this.menuItem4.Click += new System.EventHandler(this.menuItem4_Click);
			// 
			// menuItem7
			// 
			this.menuItem7.Text = "Normal";
			this.menuItem7.Click += new System.EventHandler(this.menuItem7_Click);
			// 
			// Form1
			// 
			this.ClientSize = new System.Drawing.Size(234, 258);
			this.Menu = this.mainMenu1;
			this.Text = "Connect4";
			this.MouseDown += new System.Windows.Forms.MouseEventHandler(this.Form1_MouseDown);
			this.Paint += new System.Windows.Forms.PaintEventHandler(this.Form1_Paint);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>

		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void Form1_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
		{
			e.Graphics.FillRectangle(new SolidBrush(Color.RoyalBlue),15,70,210,180);
			Draw(e.Graphics);
		}

		public void Draw(Graphics g)
		{
			Pen p=new Pen(Color.Black);
			
			g.DrawRectangle(p,15,70,210,180);
			
            int q=0;
			int w=5;

			for(int y=cy;y<cy+180;y+=30)
			{
				for(int x=cx;x<cx+210;x+=30)
				{
					if(b.arr[q,w]==0)
						g.FillEllipse(new SolidBrush(Color.White),x+3,y+3,27,27);
					if(b.arr[q,w]==1)
						g.FillEllipse(new SolidBrush(Color.Yellow),x+3,y+3,27,27);
					if(b.arr[q,w]==2)
						g.FillEllipse(new SolidBrush(Color.Red),x+3,y+3,27,27);
					g.DrawEllipse(p,x+3,y+3,27,27);
					q++;
				}
				q=0;
				w--;
			}
		}

		private void Form1_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if(b.endt==0)
			{
				if((e.X>cx)&&(e.X<cx+210))
				{
					if((e.Y>cy)&&(e.Y<cy+180))
					{
						int selection=(e.X-cx)/30;
						if((selection>=0)&&(selection<7))
						{
							if(b.add(selection,b.plr)==0)
							{
								Draw(this.CreateGraphics());

								b.turncheck();
								b.turn=b.cpu;
								if (b.endt==0)
								{
									int ck;
									b.col=b.Think();
									ck=b.add(b.col,b.cpu);
									if (ck==0)
									{
										b.lin=6-b.tops[b.col];
										b.turn=b.plr;
									}
								}
								Draw(this.CreateGraphics());
								b.turncheck();
							}
						}
					}
				}
			}
		}

		private void menuItem4_Click(object sender, System.EventArgs e)
		{
			menuItem4.Checked=true;
			menuItem3.Checked=false;
			menuItem7.Checked=false;

			//Hard
			Level=7;
			b=new Connect4Board();
			b.rec=Level;
			Invalidate();
		}

		private void menuItem7_Click(object sender, System.EventArgs e)
		{
			menuItem4.Checked=false;
			menuItem3.Checked=false;
			menuItem7.Checked=true;

			//Normal
			Level=5;
			b=new Connect4Board();
			b.rec=Level;
			Invalidate();
		}

		private void menuItem3_Click(object sender, System.EventArgs e)
		{
			menuItem3.Checked=true;
			menuItem4.Checked=false;
			menuItem7.Checked=false;
			
			//Easy
			Level=3;
			b=new Connect4Board();
			b.rec=Level;
			Invalidate();
		}

		private void menuItem6_Click(object sender, System.EventArgs e)
		{
			//Player First
			b=new Connect4Board();
			b.rec=Level;
			Invalidate();
		}

		private void menuItem5_Click(object sender, System.EventArgs e)
		{
			//CPU First
			b=new Connect4Board();
			b.rec=Level;
			Draw(this.CreateGraphics());
			b.turn=b.cpu;
			if (b.endt==0)
			{
				int ck;
				b.col=b.Think();
				ck=b.add(b.col,b.cpu);
				if (ck==0)
				{
					b.lin=6-b.tops[b.col];
					b.turn=b.plr;
				}
			}
			Draw(this.CreateGraphics());
			b.turncheck();
		}

		
	}
}

/*
 * Created by SharpDevelop.
 * User: Admin
 * Date: 20.10.2010
 * Time: 16:26
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;

namespace pm.math
{
	/// <summary>
	/// RMNK - рекурентный метод найименьших квадратов 
	/// </summary>
	public class RMNK
	{
	    private float   PhaseIncriment;
	    private float[] MjuX;
	    private float   phi, delta_phi;
		public RMNK() {
			MjuX = new float[3];
			
		}
	    public void Init ( float AlgoFreq, float GyroFreq, float mju ){
	    	Math
			PhaseIncriment =  * GyroFreq / AlgoFreq;
			
			phi      = 0;
			base_sin = 0;
			base_cos = 0;
			
			Qx[0] = (float)0.0;
			Qx[1] = (float)0.0;
			Qx[2] = (float)0.0;
			
			// ------ Значения MjuX могут меняться (это скорость сходимости) -----
			MjuX[0] = mju;
			MjuX[1] = mju;
			MjuX[2] = mju;
	    	
	    }
	}
}

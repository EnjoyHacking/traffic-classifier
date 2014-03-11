package simpleHMM1;

public class HMMParams 
{
	private double[][] params;
	private int n;
	
	public HMMParams(double[][] transitionMatrix, int n)
	{
		this.n = n;
		params = new double[(int)Math.pow(2, n)][2];
		
		for(int i = 0; i < (int)Math.pow(2, n); i++)
			for(int j = 0; j < 2; j++)
			{
				params[i][j] = transitionMatrix[i][j];
			}
		
	}
	
	public void Print()
	{
		for(int i = 0; i < (int)Math.pow(2, n); i++)
			System.out.println(String.valueOf(params[i][0]) + " " + String.valueOf(params[i][1]));
	}
}

package simpleHMM1;

public class Main 
{
	public static void main(String[] args) 
	{
		HMMData data = new HMMData("allObr3.csv");
		
		int[] tresholds = {60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170};
		int[] ns        = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};
		
		float[][] accMatrix = new float[ns.length][tresholds.length];
		
		int a = ns.length;
		int b = tresholds.length;
		
		int maxn = -1;
		int maxtr = -1;
		float max = -1.0f;
		
		int nTrials = 10;
		
		int idxn = 0;
		for(int n : ns)
		{
			int idxtr = 0;
			for(int tr : tresholds)
			{
				float accuracy = data.TestAndTrain(tr, n) * 100;
				
				accMatrix[idxn][idxtr++] = accuracy;
				
				if(accuracy > max)
				{
					max = accuracy;
					maxn = n;
					maxtr = tr;
				}
			}
			idxn++;
		}
		
		System.out.format("\nOptimal n:  %d\n", maxn);
		System.out.format("Optimal tr: %d\n", maxtr);
		System.out.format("Accuracy: %.2f%%\n", data.TestAndTrain(maxtr, maxn)*100);
		
		int idxtr = 0;
		for(int tr : tresholds)
		{
			idxn = 0;
			for(int n : ns)
			{
				System.out.format("%.2f%%  ", accMatrix[idxn++][idxtr]);
			}
			idxtr++;
			System.out.println();
		}
		

	}

}


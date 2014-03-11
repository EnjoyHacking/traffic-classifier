package simpleHMM1;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.*;

public class HMMData 
{
    private Vector<Integer> Vday;
    private Vector<Integer> Vmonth;
    private Vector<Integer> Vyear;
    private Vector<Integer> Vhour;
    private Vector<Integer> Vminute;
    private Vector<Integer> VprevFreq;
    private Vector<Float> VprevAvgSpeed;
    private Vector<Integer> Vfreq;
    private Vector<Float> VavgSpeed;
    
    private Vector<Integer> testIdx;
    private Vector<Integer> trainIdx;
    private int segmentSize = 100;
	
	public HMMData(String path)
	{
		// Initializing data
        FileInputStream fis = null;
        BufferedReader reader = null;
        
		Random generator = new Random();
		float testSetPercentage = 0.3f;
		
		int nSegments;
		
		testIdx = new Vector<Integer>();
		trainIdx = new Vector<Integer>();
        
        Vday         = new Vector<Integer>();
        Vmonth       = new Vector<Integer>();
        Vyear        = new Vector<Integer>();
        Vhour        = new Vector<Integer>();
        Vminute      = new Vector<Integer>();
        VprevFreq    = new Vector<Integer>();
        VprevAvgSpeed  = new Vector<Float>();
        Vfreq        = new Vector<Integer>();
        VavgSpeed      = new Vector<Float>();
        
        // Try to load file
        try 
        {
            fis = new FileInputStream(path);
            reader = new BufferedReader(new InputStreamReader(fis));

            String line = reader.readLine();
            while(line != null)
            {
            	// ******** Citanje linije po linije ******
                String data[] = line.split(" ");
                
                if(data.length != 9)
                {
                	line = reader.readLine();
                	continue;
                }               
                
                Vday.add(Integer.parseInt(data[0]));
                Vmonth.add(Integer.parseInt(data[1]));
                Vyear.add(Integer.parseInt(data[2]));
                Vhour.add(Integer.parseInt(data[3]));
                Vminute.add(Integer.parseInt(data[4]));
                VprevFreq.add(Integer.parseInt(data[5]));
                Vfreq.add(Integer.parseInt(data[7]));
                VprevAvgSpeed.add(Float.parseFloat(data[6]));
                VavgSpeed.add(Float.parseFloat(data[8]));
                
                
                
                // *****************************************
                
                line = reader.readLine();
            }           
          
        } 
        catch (FileNotFoundException ex) 
        {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
        catch (IOException ex) 
        {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex); 
        } 
        finally 
        {
            try 
            {
                reader.close();
                fis.close();
            } 
            catch (IOException ex) 
            {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
		// Divide data set on train set and test set
        nSegments = GetNumberOfData() / segmentSize;
		for(int i = 0; i < nSegments; i++)
		{
			if(generator.nextFloat() < testSetPercentage)
				testIdx.add(i);
			else
				trainIdx.add(i);
		}
	}
	
	public int GetNumberOfData()

	{
		return Vday.size();
	}

	public float TestAndTrain(int tr, int n)
	{
		int[] states = GetStates(tr);
		
		double[][] counts = new double[(int)Math.pow(2, n)][2];
		for(int i = 0; i < (int)Math.pow(2, n); i++)
			for(int j = 0; j < 2; j++)
			{
				counts[i][j] = 0.0d;
			}
		
		
		for(int i : trainIdx)
		{
			for(int j = i * segmentSize + n; j < (i+1) * segmentSize - 1; j++)
			{					
				int idx = 0;
				for(int k = 0; k < n; k++)
				{
					idx += states[k + j - n] * (int)Math.pow(2, k);
				}
				
				if(states[j + 1] == 0)
					counts[idx][0] += 1.0d;
				else 
					counts[idx][1] += 1.0d;
			}
		}
		
		for(int i = 0; i < (int)Math.pow(2, n); i++)
		{
			double sum = (counts[i][0] + counts[i][1]);
			for(int j = 0; j < 2; j++)
			{
				counts[i][j] = counts[i][j] / sum;
			}
		}
		
		int totalPredictions = 0;
		int successfulPredictions = 0;
		
		for(int c:testIdx)
		{
			for(int j = c * segmentSize + n; j < (c+1) * segmentSize - 1; j++)
			{
				totalPredictions++;
				
				int idx = 0;
				for(int k = 0; k < n; k++)
				{
					idx += states[k + j - n] * (int)Math.pow(2, k);
				}
				
				int pred = 0;
				if (counts[idx][1] > 0.5d)
					pred = 1;
				
				if(states[j + 1] == pred)
					successfulPredictions++;
			}
		}
		
		return (float)successfulPredictions/totalPredictions;
	}

	private int[] GetStates(int tr) 
	{
		int n = Vfreq.size();
		int[] states = new int[n];
		
		for(int i = 0; i < n; i++)
		{
			if(Vfreq.elementAt(i) > tr)
				states[i] = 1;
			else
				states[i] = 0;
		}
		
		return states;
	}
}

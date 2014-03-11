fido = fopen ('obrBNT.csv', 'w');

for month = 1:3

    % Otvaranje datoteke
    fid  = fopen (sprintf('%dobr.csv',    month), 'r');


    prevInterval = 0;
    interval = 0;
    prevIntervalCounter = 0;
    intervalCounter = 0;
    prevAvgVelocity = 0;
    avgVelocity = 0;
    sumVelocity = 0;

    lineNum = 0;

    % Obrada - izvlacenje dana u tjednu
    while(~feof(fid))
    
 
        
        

        line = fgetl(fid);
        lineData = str2num(line);
        
        velocity = lineData(1);
        
        % Only for cars in positive direction
        if velocity > 0

            interval = MinutesToIntervalBNT(lineData(8));
            
            if interval == prevInterval
                sumVelocity = sumVelocity + lineData(1);
                intervalCounter = intervalCounter + 1;
            else
                prevInterval = interval;
                if intervalCounter > 0
                    avgVelocity = sumVelocity / intervalCounter;
                else
                    avgVelocity = 0;
                end
                
                dayofTheWeek      = DatetoDay(lineData(4), lineData(5), lineData(6));
                totalMinutesInDay = IntervalToMinutesBNT(interval) + 60 * lineData(7);
                
                fprintf(fido, '%d %d %d %f\n', totalMinutesInDay, ...
                                               dayofTheWeek,...
                                               intervalCounter,...
                                               avgVelocity);

                prevIntervalCounter = intervalCounter;
                sumVelocity = lineData(1);
                prevAvgVelocity = avgVelocity;
                intervalCounter = 1;
            end
            
        end

    end


    fclose(fid);

    fprintf('%d\n', month);

end

fclose(fido);

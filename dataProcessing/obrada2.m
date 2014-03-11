for month = 1:12

% Otvaranje datoteke
fid = fopen (sprintf('%dobr.csv', month), 'r');
fido = fopen (sprintf('%dobr2.csv', month), 'w');

prevInterval = 0;
interval = 0;
prevIntervalCounter = 0;
intervalCounter = 0;

lineNum = 0;

% Obrada - izvlacenje dana u tjednu
while(~feof(fid))

    line = fgetl(fid);
    lineData = str2num(line);
    lineNum = lineNum + 1;
    fprintf('%d\n', lineNum);
    
    % Only for cars in positive direction
    if lineData(1) > 0
        % First iteration
        if prevInterval == 0
            prevInterval = MinutesToInterval(lineData(8));
        end
        
        interval = MinutesToInterval(lineData(8));
        
        if interval == prevInterval
            intervalCounter = intervalCounter + 1;
        else
            prevInterval = interval;
            fprintf(fido, '%d %d %d %d %d %d %d\n', lineData(4), lineData(5), lineData(6), lineData(7), IntervalToMinutes(interval), prevIntervalCounter, intervalCounter);
            % + Izbrisati prvi jer je prevCounter = 0 i zadnji jer nije
            % reprezentativan!!!
            prevIntervalCounter = intervalCounter;
            intervalCounter = 1;
        end
        
    end

end

fprintf('%d\n', month);

fclose(fid);
fclose(fido);

end
% Otvaranje datoteke
fid = fopen ("filteredData2.csv", 'r');
fido = fopen ("filteredData2o.csv", 'w');
line = fgetl(fid);

datePrev = '          ';
i = 0;

% Obrada - izvlacenje dana u tjednu
while ~feof(fid)

    line = fgetl(fid);
    dateNow = line(1:10);
    
    if (sum(dateNow ~= datePrev) > 0)
        datePrev = dateNow;
        i += 1
    end
    
    % Dan u tjednu
    if (mod(i, 7) == 1) line = strcat(line, ',Sunday'); end;
    if (mod(i, 7) == 2) line = strcat(line, ',Monday'); end;
    if (mod(i, 7) == 3) line = strcat(line, ',Tuesday'); end;
    if (mod(i, 7) == 4) line = strcat(line, ',Wednesday'); end;
    if (mod(i, 7) == 5) line = strcat(line, ',Thirsday'); end;
    if (mod(i, 7) == 6) line = strcat(line, ',Friday'); end;
    if (mod(i, 7) == 0) line = strcat(line, ',Saturday'); end;
    
    % Vrijeme u danu s minutama
    line = strcat(line, strcat(',', line(12:16)));
    % Vrijeme u danu bez minuta
    line = strcat(line, strcat(',', line(12:13)));
    
    fprintf(fido, '%s\n', line);

end

fclose(fid);
fclose(fido);
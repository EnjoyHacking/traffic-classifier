% Otvaranje datoteke
fid = fopen ('12.asc', 'r');
fido = fopen ('12obr.csv', 'w');
line = fgetl(fid);

i = 0;

% Obrada - izvlacenje dana u tjednu
while ~feof(fid)

    line = fgetl(fid);
    i = i + 1;
    
    for j = 1:length(line)
        if line(j) == ';' || line(j) == '.' || line(j) == ':' 
            line(j) = ' ';
        end
        if line(j) == ',' 
            line(j) = '.';
        end
    end
    
    fprintf('%d\n', i);
    fprintf(fido, '%s\n', line);

end

fclose(fid);
fclose(fido);
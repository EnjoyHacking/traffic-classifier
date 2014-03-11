% Otvaranje datoteke
input = load('allObr3.csv');
fido1 = fopen ('HMMObservations.csv', 'w');
fido2 = fopen ('HMMStates.csv', 'w');

for i = 1:size(input, 1) - 1
%     if(mod(i, 24*4*7) == 1)
%         fprintf(fido1, '\n');
%         fprintf(fido2, '\n');
% %         fprintf('%d\n', input(i, 7));
%     end
%     fprintf(fido1, '%d ', ObservationToSymbol4(input(i,1), input(i,2), input(i,3), input(i,4), input(i,6), input(i,7)));
%     fprintf(fido2, '%d ', StateEstimate2(input(i,8), input(i,9)));

if(mod(input(i,5), 60) ~= mod(input(i +1 ,5) - 15, 60))
    i
    [input(i,:);input(i+1,:)]
end
    
    % fprintf('%d\r', i);
end

fclose(fido1);
fclose(fido2);
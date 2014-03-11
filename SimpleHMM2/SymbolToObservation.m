function [assignment strObservations] = SymbolToObservation(symbol, card)

assignment = mod(floor(repmat(symbol - 1, 1, length(card)) ./ repmat(cumprod([1, card(1:end - 1)]), 1, 1)), ...
        repmat(card, 1, 1)) + 1;

% Time of the year:
% 1 - spring
% 2 - summer
% 3 - autumn
% 4 - winter
if assignment(1) == 1
strObservations = 'Spring, ';
elseif assignment(1) == 2
strObservations = 'Summer, ';
elseif assignment(1) == 3
strObservations = 'Autumn, ';
else
strObservations = 'Winter, ';
end

% Time of the week:
% 1 - Sunday
% ...
% 7 - Saturday
if assignment(2) == 1
strObservations = strcat(strObservations, 'Sunday, ');
elseif assignment(2) == 2
strObservations = strcat(strObservations, 'Monday, ');
elseif assignment(2) == 3
strObservations = strcat(strObservations, 'Tuesday, ');
elseif assignment(2) == 4
strObservations = strcat(strObservations, 'Wednesday, ');
elseif assignment(2) == 5
strObservations = strcat(strObservations, 'Thursday, ');
elseif assignment(2) == 6
strObservations = strcat(strObservations, 'Friday, ');
else
strObservations = strcat(strObservations, 'Saturday, ');
end


% Hour:
% 1
% ...
% 24
strHelp = strcat(sprintf('%d', assignment(3)), ', ');
strObservations = strcat(strObservations, strHelp);


% Frequency of cars:
% 1 - [0,25]
% ...
% 4 - <76, inf>
if assignment(2) == 1
strObservations = strcat(strObservations, '[0, 25] ');
elseif assignment(2) == 2
strObservations = strcat(strObservations, '<26, 50] ');
elseif assignment(2) == 3
strObservations = strcat(strObservations, '<51, 75] ');
else
strObservations = strcat(strObservations, '<66, inf> ');

end


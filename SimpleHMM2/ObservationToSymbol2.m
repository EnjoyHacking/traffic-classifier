function [symbol card] = ObservationToSymbol2(day, month, year, hour, prevFrequency)

assignment = zeros(1, 3);
card = zeros(1, 3);

% Time of the week:
% 1 - Sunday
% ...
% 7 - Saturday
card(1) = 7;
if month == 1
    strMonth = 'Jan';
elseif month == 2
    strMonth = 'Feb';
elseif month == 3
    strMonth = 'Mar';
elseif month == 4
    strMonth = 'Apr';
elseif month == 5
    strMonth = 'May';
elseif month == 6
    strMonth = 'Jun';
elseif month == 7
    strMonth = 'Jul';
elseif month == 8
    strMonth = 'Aug';
elseif month == 9
    strMonth = 'Sep';
elseif month == 10
    strMonth = 'Oct';
elseif month == 11
    strMonth = 'Nov';
else 
    strMonth = 'Dec';
end

str = sprintf('%d-%s-%d', day, strMonth, year);
assignment(1) = weekday(str);

% Hour:
% 1 - [23, 4]
% 2 - 5
%...
% 19 - 22
card(2) = 19;
if hour == 23 || hour == 24 || hour == 0 || hour == 1 || hour == 2 ||hour == 3 || hour == 4
    assignment(2) = 1;
else
    assignment(2) = hour - 3;
end

% Frequency of cars:
% 1 - [0,25]
% ...
% 4 - <76, inf>
card(3) = 4;
if prevFrequency > 75
    assignment(3) = 4;
elseif prevFrequency > 50
    assignment(3) = 3;
elseif prevFrequency > 25
    assignment(3) = 2;
else
    assignment(3) = 1;
end

% Daphne Kollere - Assignment to Index
if (any(size(assignment) == 1)),
    symbol = cumprod([1, card(1:end - 1)]) * (assignment(:) - 1) + 1;
else
    symbol = sum(repmat(cumprod([1, card(1:end - 1)]), size(assignment, 1), 1) .* (assignment - 1), 2) + 1;
end;

end


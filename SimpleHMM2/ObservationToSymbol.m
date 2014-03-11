function [symbol card] = ObservationToSymbol(day, month, year, hour, prevFrequency)

assignment = zeros(1, 4);
card = zeros(1, 4);

% Time of the year:
% 1 - spring
% 2 - summer
% 3 - autumn
% 4 - winter
card(1) = 4;
if month == 12 || month == 1 || month == 2
   assignment(1) = 4; 
end
if month == 3 || month == 4 || month == 5
   assignment(1) = 1; 
end
if month == 6 || month == 7 || month == 8
   assignment(1) = 2; 
end
if month == 9 || month == 10 || month == 11
   assignment(1) = 3; 
end

% Time of the week:
% 1 - Sunday
% ...
% 7 - Saturday
card(2) = 7;
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
assignment(2) = weekday(str);

% Hour:
% 1
% ...
% 24
card(3) = 24;
if hour == 0
    assignment(3) = 24;
else
    assignment(3) = hour;
end

% Frequency of cars:
% 1 - [0,25]
% ...
% 4 - <76, inf>
card(4) = 4;
if prevFrequency > 75
    assignment(4) = 4;
elseif prevFrequency > 50
    assignment(4) = 3;
elseif prevFrequency > 25
    assignment(4) = 2;
else
    assignment(4) = 1;
end

% Daphne Kollere - Assignment to Index
if (any(size(assignment) == 1)),
    symbol = cumprod([1, card(1:end - 1)]) * (assignment(:) - 1) + 1;
else
    symbol = sum(repmat(cumprod([1, card(1:end - 1)]), size(assignment, 1), 1) .* (assignment - 1), 2) + 1;
end;

end


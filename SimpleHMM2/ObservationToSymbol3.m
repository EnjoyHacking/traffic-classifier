function [symbol card] = ObservationToSymbol3(day, month, year, hour, prevFrequency)

assignment = zeros(1, 4);
card = zeros(1, 4);

% Time of the week:
% 1 - Monday
% 2 - Tuesday, Wednesday, Thursday
% 3 - Friday
% 4 - Saturday, Sunday
card(1) = 4;
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
day = weekday(str);
if day == 1 || day == 7
    assignment(1) = 4;
elseif day == 2
    assignment(1) = 1;
elseif day == 6
    assignment(1) = 3;
else
    assignment(1) = 2;
end

% Hour:
% 1 - [0, 6>
% 2 - [6, 10>
% 3 - [10, 15>
% 4 - [15, 19>
% 5 - [19, 24>

card(2) = 5;
if  hour == 0 || hour == 1 || hour == 2 ||hour == 3 || hour == 4  || hour == 5
    assignment(2) = 1;
elseif hour == 6 || hour == 7 || hour == 8 || hour == 9
    assignment(2) = 2;
elseif hour == 10 || hour == 11 || hour == 12 || hour == 13 || hour == 14
    assignment(2) = 3;
elseif hour == 15 || hour == 16 || hour == 17 || hour == 18
    assignment(2) = 4;
else
    assignment(2) = 5;
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

% Time of the year:
% 1 - Summer seson
% 2 - Rest
card(4) = 2;
if month == 6 || month == 7 || month == 8 || month == 9 
    assignment(4) = 1;
else
    assignment(4) = 2;
end


% Daphne Kollere - Assignment to Index
if (any(size(assignment) == 1)),
    symbol = cumprod([1, card(1:end - 1)]) * (assignment(:) - 1) + 1;
else
    symbol = sum(repmat(cumprod([1, card(1:end - 1)]), size(assignment, 1), 1) .* (assignment - 1), 2) + 1;
end;

end


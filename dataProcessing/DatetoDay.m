function [day] = DatetoDay(day, month, year)

% Time of the week:
% 1 - Sunday
% ...
% 7 - Saturday
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

end


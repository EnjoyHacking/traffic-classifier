function intervalSymbol = MinutesToInterval(minuteInHour)

if minuteInHour < 15
    intervalSymbol = 1;
elseif minuteInHour < 30
    intervalSymbol = 2;
elseif minuteInHour < 45
    intervalSymbol = 3;
else
    intervalSymbol = 4;

end


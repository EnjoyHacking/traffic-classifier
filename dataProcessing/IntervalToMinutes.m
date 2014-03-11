function minuteInHour = IntervalToMinutes(intervalSymbol)

if intervalSymbol == 1
    minuteInHour = 0;
elseif intervalSymbol == 2
    minuteInHour = 15;
elseif intervalSymbol == 3
    minuteInHour = 30;
else
    minuteInHour = 45;

end


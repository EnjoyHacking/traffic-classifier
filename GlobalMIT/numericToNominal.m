function [ ret ] = numericToNominal( data )

ret = data;

mean = sum(data)/length(data);
sd = std(data);


idx = find((data < mean - 1.5 *sd) + (data > mean + 1.5*sd));
ret(idx) = 4;

idx = find((data >= mean - 1.5 *sd) .* (data <= mean + 1.5*sd));
ret(idx) = 3;

idx = find((data >= mean - sd) .* (data <= mean + sd));
ret(idx) = 2;

idx = find((data >= mean - 0.5 *sd) .* (data <= mean + 0.5*sd));
ret(idx) = 1;

end


function [ ret ] = minute( min )

ret = zeros(size(min));

idx = find(min == 0);
ret(idx) = 1;


idx = find(min == 15);
ret(idx) = 2;


idx = find(min == 30);
ret(idx) = 3;


idx = find(min == 45);
ret(idx) = 4;


end


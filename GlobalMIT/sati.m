function [ ret ] = sati( min )
%SATI Summary of this function goes here
%   Detailed explanation goes here
ret = min;

idx = find(min == 0);
ret(idx) = 24;

end


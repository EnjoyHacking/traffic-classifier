function prob = probParam(dataVec, winSize, epsilon, type = 'n')

prob = 0;
numExampl = 0;
isGuzva = zeros(size(dataVec));
N = size(dataVec, 1);

weights = zeros(winSize, 1);
if(type == 'n')                            % Weights - normal
    weights(1) = normcdf(1 - 0.5 * winSize);
    for i = 2:(winSize - 1)
          weights(i) = normcdf(- 0.5 * winSize + i) - normcdf(- 0.5 * winSize + i - 1);
    end
    weights(winSize) = 1 - sum(weights(1:(winSize-1)));
else                                            %% Weights - uniform
    weights += 1/winSize;
end

% Rubni sluèajevi
for i = 1:winSize
    isGuzva(i) = isGuzva(N - i + 1) = NaN;
end
% Ostali sluèajevi
for i = (winSize + 1):(N - winSize)
    numExampl += 1;
    lowerLimit = i - floor(winSize/2);
    avg = weights' * dataVec(lowerLimit:(lowerLimit + winSize - 1));
    if avg > epsilon
        prob += 1;
        isGuzva(i) = 1;
    end
end

prob = prob / numExampl;

end
%%%%%%

load X.txt;
load y.txt;

N = length(y);
perm = randperm(N);

Ntrain = floor(0.6 * N);
idxtrain = perm(1:Ntrain);
idxtest  = perm(Ntrain + 1:floor(0.8 * N));

Xtrain = X(idxtrain, :);
ytrain = y(idxtrain);

Xtest = X(idxtest, :);
ytest = y(idxtest);

C = [1 5 10 50 100 500 1000 5000 10000 50000];

for i = 1:length(C)
    opt = sprintf('-c %f -q', C(i));
    model = svmtrain(ytrain, Xtrain, opt);
    [dummy1 accuracy dummy2] = svmpredict(ytest, Xtest, model);
end
% [dummy1 accuracy dummy2] = svmpredict(ytest, Xtest, model);
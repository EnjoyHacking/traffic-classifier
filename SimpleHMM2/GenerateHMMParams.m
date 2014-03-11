%%% Loading files
seq = load('HMMObservations.csv');
states = load('HMMStates.csv');

N = size(seq, 1);
Ntrain = floor(0.8 * N);

perm = randperm(N);
idxtrain = perm(1:Ntrain);
idxtest  = perm(Ntrain + 1:end);

seqtrain = seq(idxtrain, :)';
seqtest  = seq(idxtest,  :)';

%%% Initial matrices
load HMMparamsEstimate.mat;

%%% Training
[TRANS EMIS] = hmmtrain(seqtrain(:), TRANS, EMIS);

TRANS

save HMMparamsTrain.mat TRANS EMIS
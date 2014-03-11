%%% Loading files
seq = load('HMMObservations.csv');
states = load('HMMStates.csv');

seq = seq';
states = states';

[TRANS EMIS] = hmmestimate(seq(:), states(:));

save HMMparamsEstimate.mat TRANS EMIS
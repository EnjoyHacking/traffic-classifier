%%%%%%% Params evaluation

%%% Loading params
load HMMparams2Estimate.mat;
obs = load('HMMObservations2.csv');
states = load('HMMStates.csv');

error = 0;

for i = 1:length(obs) - 4
    PSTATE = hmmdecode([obs(i) obs(i+1)], TRANS, EMIS);
    [dummy predState] = max(PSTATE);
    error = error + (1/(length(obs) - 4)) * (1 - (predState == states(i)));
end

error
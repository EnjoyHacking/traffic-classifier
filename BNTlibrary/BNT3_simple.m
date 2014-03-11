%%% Varijable
% 1 - Frekvencija u tom periodu

% Veze unutar vremenskog odsjecka
intra = zeros(2); 
intra(1, 2) = 1;

% Veze izmedju vremenskih odsjecaka
inter = zeros(2);
inter(1, 1) = 1; 

dnodes = [];
onodes = [2]; 

bnet = mk_dbn(intra, inter, [1 1], 'observed', onodes, 'discrete', dnodes); 

bnet.CPD{1} = gaussian_CPD(bnet, 1);
bnet.CPD{2} = gaussian_CPD(bnet, 2);
bnet.CPD{3} = gaussian_CPD(bnet, 3);
bnet.CPD{4} = gaussian_CPD(bnet, 4);


engine = smoother_engine(jtree_2TBN_inf_engine(bnet));

load obrBNT.csv;
ss = 2;%slice size(ss)
ncases = 1;%number of examples
T = floor(size(obrBNT, 1) * 0.1);
max_iter=4;%iterations for EM
cases = cell(1, ncases);
for i=1:ncases
    cases{i} = cell(ss,T);
    cases{i}(2, :) = num2cell(obrBNT(1:T, [1])');
    cases{i}(1, :) = num2cell(obrBNT(1:T, [4])');

end
[bnet3, LLtrace] = learn_params_dbn_em(engine, cases, 'max_iter', max_iter)
% 
%engine = enter_evidence(engine, num2cell(obrBNT(T+1:2*T, 4)'));
% m = marginal_nodes(engine, 2, 1:4)


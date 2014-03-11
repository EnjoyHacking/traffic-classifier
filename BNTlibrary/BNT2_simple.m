%%% Varijable
% 1 - Dan u tjednu
% 2 - Frekvencija u tom periodu

% Veze unutar vremenskog odsjecka
intra = zeros(1); 

% Veze izmedju vremenskih odsjecaka
inter = zeros(1);
inter(1,1) = 1; 

dnodes = 1;
onodes = 1; 

bnet = mk_dbn(intra, inter, [7], 'observed', onodes, 'discrete', dnodes); 


for i=1:2
  bnet.CPD{i} = tabular_CPD(bnet, i);
end

engine = smoother_engine(jtree_2TBN_inf_engine(bnet));

load obrBNT.csv;
ss = 1;%slice size(ss)
ncases = 1;%number of examples
T=1000;
max_iter=2;%iterations for EM
cases = cell(1, ncases);
for i=1:ncases
    cases{i} = cell(ss,T);
    cases{i}(1, :) = num2cell(obrBNT(1:T, 2)');

end
[bnet2, LLtrace] = learn_params_dbn_em(engine, cases, 'max_iter', max_iter)
%%% Varijable
% 1 - Minute u danu
% 2 - Dan u tjednu
% 3 - Frekvencija u tom periodu
% 4 - Prosjecna brzina u tom periodu

% Veze unutar vremenskog odsjecka
intra = zeros(4);
intra(1,3) = 1;
intra(2,3) = 1;
intra(1,4) = 1;  
intra(3,4) = 1;  

% Veze izmedju vremenskih odsjecaka
inter = zeros(4);
inter(3,3) = 1; 
inter(4,4) = 1;

dnodes = [];
onodes = 1:4; 

eclass1 = [1 2 3 4];
eclass2 = [1 2 5 6];
eclass = [eclass1 eclass2];

bnet = mk_dbn(intra, inter, [1 1 1 1], 'discrete', dnodes, 'names', {'TimeOfDay','Day','Freq','AvgSpeed'}, 'observed', onodes, 'eclass1', eclass1, 'eclass2', eclass2); 

for i=2:2
  bnet.CPD{i} = tabular_CPD(bnet, i);
end

for i=[1 3 4 5 6]
  bnet.CPD{i} = gaussian_CPD(bnet, i);
end

engine = smoother_engine(jtree_2TBN_inf_engine(bnet));

load obrBNT.csv;
ss = 4;%slice size(ss)
ncases = 1;%number of examples
T=1000;
max_iter=2;%iterations for EM
cases = cell(1, ncases);
for i=1:ncases
    cases{i} = cell(ss,T);
    cases{i} = num2cell(obrBNT(1:T, :)');

end
[bnet2, LLtrace] = learn_params_dbn_em(engine, cases, 'max_iter', 1)